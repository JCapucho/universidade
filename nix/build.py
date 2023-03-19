#!/usr/bin/env python3
import argparse
import json
from pathlib import Path

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

env = Environment(loader=FileSystemLoader("templates"), autoescape=select_autoescape())

env.trim_blocks = True
env.lstrip_blocks = True

template = env.get_template("home.jinja")
source_template = env.get_template("source-code.jinja")

site_data = json.load(program_args.map)

template.stream(
    title=site_data["title"],
    author=site_data["author"],
    description=site_data["description"],
    sitemap=site_data["content"],
).dump(str(program_args.build_dir / "index.html"))
