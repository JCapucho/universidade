#!/usr/bin/env python3
import os
import sys
import argparse
import subprocess
import json
import shutil
from pathlib import Path
from dataclasses import field, dataclass
from jinja2 import Environment, FileSystemLoader, select_autoescape

# Find the directory of the script and normalize it
# (set strict=True because we want to verify the file exists)
script_dir = Path(__file__).resolve(True).parent

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
    default=script_dir / "build",
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
        "python3",
        state["builder"],
        program_args.build_dir / workdir,
        name,
    ]

    builderArgs.extend(args)

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


def processNodeDownload(_name, raw_node, state):
    workdir = state.get("workdir", Path("."))

    source = Path(raw_node["target"])
    filename = source.name

    link = workdir / filename
    target = program_args.build_dir / link

    os.makedirs(target.parent, exist_ok=True)

    shutil.copyfile(source, target)

    return SiteLink(link, True)


runners = {
    "builder": processNodeBuilder,
    "invocation": processNodeInvocation,
    "link": processNodeLink,
    "group": processNodeGroup,
    "download": processNodeDownload,
}


def processNodeGeneric(raw_node, state):
    child_state = state.copy()

    name = raw_node["name"]
    type = raw_node["type"] if raw_node.get("type") is not None else state["type"]

    link = runners[type](name, raw_node, child_state)

    children = []

    for child in raw_node.get("children", []):
        children.append(processNodeGeneric(child, child_state))

    return SiteNode(name, link, children)


site_data = json.load(program_args.map)
sitemap = []

initial_state = {}

for raw_node in site_data:
    sitemap.append(processNodeGeneric(raw_node, initial_state))

env = Environment(loader=FileSystemLoader("templates"), autoescape=select_autoescape())
template = env.get_template("template.jinja")

template.stream(
    title="Resumos Universidade",
    author="João Capucho",
    description="Resumos para as unidades curriculares da Licenciatura de Engenharia Informática da universidade de aveiro",
    sitemap=sitemap,
).dump(str(program_args.build_dir / "index.html"))
