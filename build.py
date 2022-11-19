#!/usr/bin/env python3
import os
import sys
import time
import json
import shutil
import logging
import argparse
import subprocess
from pathlib import Path
from dataclasses import field, dataclass
from jinja2 import Environment, FileSystemLoader, select_autoescape

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


@dataclass
class SiteLink:
    href: str
    download: bool = False


@dataclass
class SiteNode:
    name: str
    link: SiteLink | None = None
    children: ["SiteNode"] = field(default_factory=list)


def processNodeBuilder(_name, raw_node, state):
    processNodeGroup(_name, raw_node, state)
    state["builder"] = raw_node["builder"]
    state["args"] = state.get("args", []) + raw_node.get("args", [])
    state["type"] = "invocation"


def processNodeInvocation(name, raw_node, state):
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

    process = subprocess.run(builderArgs)

    if process.returncode > 0:
        print(f"Failed to build page {name}", file=sys.stderr)
        sys.exit(1)

    return SiteLink(workdir / "index.html")


def processNodeLink(_name, raw_node, state):
    workdir = state.get("workdir", Path("."))
    return SiteLink(workdir / raw_node["target"])


def processNodeGroup(_name, raw_node, state):
    state["workdir"] = state.get("workdir", Path(".")) / raw_node["workdir"]


def processNodeFile(_name, raw_node, state):
    workdir = state.get("workdir", Path("."))

    source = Path(raw_node["target"])
    filename = source.name

    download = raw_node.get("download", False)

    link = workdir / filename
    target = program_args.build_dir / link

    os.makedirs(target.parent, exist_ok=True)

    shutil.copyfile(source, target)

    return SiteLink(link, download)


runners = {
    "builder": processNodeBuilder,
    "invocation": processNodeInvocation,
    "link": processNodeLink,
    "group": processNodeGroup,
    "file": processNodeFile,
}


def processNodeGeneric(raw_node, state):
    child_state = state.copy()

    name = raw_node["name"]
    type = raw_node["type"] if raw_node.get("type") is not None else state["type"]

    logging.info(f"Building node '{name}' of type: '{type}'")

    start = time.perf_counter_ns()
    link = runners[type](name, raw_node, child_state)
    end = time.perf_counter_ns()

    ms = (end - start) / 1_000_000

    logging.debug(f"Took {ms:.3f}ms")

    children = []

    for child in raw_node.get("children", []):
        children.append(processNodeGeneric(child, child_state))

    return SiteNode(name, link, children)


logging.basicConfig(level=logging.DEBUG)

site_data = json.load(program_args.map)
sitemap = []

initial_state = {}

for raw_node in site_data["content"]:
    sitemap.append(processNodeGeneric(raw_node, initial_state))

env = Environment(loader=FileSystemLoader("templates"), autoescape=select_autoescape())
template = env.get_template("home.jinja")

template.stream(
    title=site_data["title"],
    author=site_data["author"],
    description=site_data["description"],
    sitemap=sitemap,
).dump(str(program_args.build_dir / "index.html"))
