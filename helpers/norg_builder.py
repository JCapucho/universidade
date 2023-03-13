#!/usr/bin/env python3
import os
import sys
import argparse
import subprocess
import shutil
from pathlib import Path

# Find the directory of the script and normalize it
# (set strict=True because we want to verify the file exists)
script_dir = Path(__file__).resolve(True).parent

parser = argparse.ArgumentParser(description="Build Norg file")
parser.add_argument(
    "--template",
    metavar="PATH",
    type=Path,
    help="The template to use",
)
parser.add_argument(
    "--static-assets",
    metavar="PATH",
    type=Path,
    help="The path to the static assets to be used",
)
parser.add_argument(
    "out",
    metavar="PATH",
    type=Path,
    help="The partial path (without extension) to the output file",
)
parser.add_argument(
    "title",
    metavar="TITLE",
    type=str,
    help="The title of the page",
)
parser.add_argument(
    "source",
    metavar="FILE",
    type=Path,
    help="The source neorg file",
)

args = parser.parse_args()

os.makedirs(args.out, exist_ok=True)
shutil.copytree(
    args.source.parent / args.static_assets,
    args.out / args.static_assets,
    dirs_exist_ok=True,
)

process = subprocess.Popen(["pandoc-norg-rs", args.source], stdout=subprocess.PIPE)

index_out = args.out / "index.html"

process = subprocess.run(
    [
        "pandoc",
        "-s",
        "--toc",
        # fmt: off
        "-f", "json",
        "--metadata", "lang=pt-PT",
        "--template", args.template,
        "--mathjax",
        "-o", index_out,
        # fmt: on
    ],
    stdin=process.stdout,
)

if process.returncode > 0:
    print(f"Failed to build page {args.title}", file=sys.stderr)
    sys.exit(1)
