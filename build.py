#!/usr/bin/env python3
import os
import sys
import argparse
import subprocess
import json
from pathlib import Path
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

args = parser.parse_args()


def runPage(object, state):
    child_state = state.copy()

    child_state["path"] = child_state["path"] / object["name"]

    if "builder" in object:
        child_state["builder"] = object["builder"]

    if "args" in object:
        child_state["args"] = object["args"]

    if "path" in object:
        object["href"] = child_state["path"] / "index.html"

        builderArgs = [
            "python3",
            child_state["builder"],
            object["path"],
            args.build_dir / child_state["path"],
        ]

        if "args" in child_state:
            builderArgs.extend(child_state["args"])

        if "title" in object:
            builderArgs.append(object["title"])

        process = subprocess.run(builderArgs)

        if process.returncode > 0:
            print(f"Failed to build page {object['name']}", file=sys.stderr)
            sys.exit(1)

    if "children" in object:
        os.makedirs(args.build_dir / child_state["path"], exist_ok=True)

        for child in object["children"]:
            runPage(child, child_state)


sitemap = json.load(args.map)

for root in sitemap:
    runPage(root, {"path": Path()})

env = Environment(loader=FileSystemLoader("templates"), autoescape=select_autoescape())
template = env.get_template("template.jinja")

template.stream(sitemap=sitemap).dump(str(args.build_dir / "index.html"))
