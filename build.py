#!/usr/bin/env python3
import argparse
import json
import logging
import os
import shutil
import sys
import time
import asyncio
import typing
from dataclasses import dataclass, field
from pathlib import Path

from jinja2 import Environment, FileSystemLoader, select_autoescape
from pygments import highlight
from pygments.formatters import HtmlFormatter
from pygments.lexers import guess_lexer_for_filename

parser = argparse.ArgumentParser(description="Build the site")
parser.add_argument(
    "--map",
    metavar="FILE",
    type=argparse.FileType("r", encoding="UTF-8"),
    help="The site map",
    default="map.json",
)
parser.add_argument(
    "--build-dir",
    metavar="PATH",
    type=Path,
    help="The directory to output to",
    default="build",
)

program_args = parser.parse_args()

env = Environment(loader=FileSystemLoader("templates"), autoescape=select_autoescape())
template = env.get_template("home.jinja")
source_template = env.get_template("source-code.jinja")


@dataclass
class SiteLink:
    href: str
    download: bool = False
    external: bool = False


@dataclass
class SiteNode:
    name: str
    link: SiteLink | None = None
    children: list["SiteNode"] = field(default_factory=list)


async def processNodeBuilder(_name, raw_node, state):
    await processNodeGroup(_name, raw_node, state)
    state["builder"] = raw_node["builder"]
    state["args"] = state.get("args", []) + raw_node.get("args", [])
    state["type"] = "invocation"


async def processNodeInvocation(name, raw_node, state):
    args = state.get("args", []) + raw_node.get("args", [])
    state["args"] = args
    workdir = state.get("workdir", Path(".")) / raw_node["workdir"]
    state["workdir"] = workdir

    if "builder" in raw_node:
        state["builder"] = raw_node["builder"]

    os.makedirs(program_args.build_dir / workdir, exist_ok=True)

    builderArgs = [
        state["builder"],
        program_args.build_dir / workdir,
        name,
    ]

    builderArgs.extend(args)

    logging.debug(f"Invocation: {builderArgs}")

    process = await asyncio.create_subprocess_exec(*builderArgs)
    await process.wait()

    if process.returncode > 0:
        print(f"Failed to build page {name}", file=sys.stderr)
        sys.exit(1)

    if raw_node.get("has_index", True):
        document = raw_node.get("target", "index.html")
        return SiteLink(workdir / document)


async def processNodeLink(_name, raw_node, state):
    workdir = state.get("workdir", Path("."))
    return SiteLink(workdir / raw_node["target"])


async def processNodeGroup(_name, raw_node, state):
    state["workdir"] = state.get("workdir", Path(".")) / raw_node["workdir"]


async def processNodeFile(_name, raw_node, state):
    workdir = state.get("workdir", Path("."))

    source = Path(raw_node["target"])
    filename = source.name

    download = raw_node.get("download", False)

    link = workdir / filename
    target = program_args.build_dir / link

    os.makedirs(target.parent, exist_ok=True)

    shutil.copyfile(source, target)

    return SiteLink(link, download)


async def processNodeExternalLink(_name, raw_node, state):
    return SiteLink(raw_node["target"], external=True)


async def processNodeCode(_name, raw_node, state):
    source = Path(raw_node["target"])
    filename = source.name

    workdir = state.get("workdir", Path("."))
    link = workdir / (filename + ".html")
    target = program_args.build_dir / link
    os.makedirs(target.parent, exist_ok=True)

    with open(source) as inf:
        srcCode = inf.read()

    lexer = guess_lexer_for_filename(filename, srcCode)

    code = highlight(srcCode, lexer, HtmlFormatter())
    source_template.stream(code=code, filename=filename, links=[]).dump(
        str(target)
    )

    return SiteLink(link)


runners = {
    "builder": processNodeBuilder,
    "invocation": processNodeInvocation,
    "group": processNodeGroup,
    "file": processNodeFile,
    "link": processNodeLink,
    "external": processNodeExternalLink,
    "code": processNodeCode,
}


async def processNodeGeneric(raw_node, state):
    child_state = state.copy()

    name = raw_node["name"]
    type = raw_node["type"] if raw_node.get("type") is not None else state["type"]

    logging.info(f"Building node '{name}' of type: '{type}'")

    start = time.perf_counter_ns()
    link = await runners[type](name, raw_node, child_state)
    end = time.perf_counter_ns()

    ms = (end - start) / 1_000_000

    logging.debug(f"Finished building node '{name}' took {ms:.3f}ms")

    children = await processChildren(raw_node.get("children", []), child_state)

    return SiteNode(name, link, children)

async def processChildren(children, state) -> list["SiteNode"]:
    tasks = []
    results: list[None | "SiteNode"] = [None] * len(children)

    for i, raw_node in enumerate(children):
        async def process(i, raw_node):
            node = await processNodeGeneric(raw_node, state)
            results[i] = node
        task = asyncio.create_task(process(i, raw_node))
        tasks.append(task)

    await asyncio.gather(*tasks)

    return typing.cast(list["SiteNode"], results)

async def main():
    site_data = json.load(program_args.map)

    sitemap = await processChildren(site_data["content"], {})

    template.stream(
        title=site_data["title"],
        author=site_data["author"],
        description=site_data["description"],
        sitemap=sitemap,
    ).dump(str(program_args.build_dir / "index.html"))

    shutil.copytree("resources", program_args.build_dir / "resources", dirs_exist_ok=True)

logging.basicConfig(level=logging.DEBUG)

asyncio.run(main())
