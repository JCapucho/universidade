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

parser = argparse.ArgumentParser(description="Build jupyter")
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
    help="The source jupyter notebook",
)
parser.add_argument(
    "--template",
    metavar="PATH",
    type=Path,
    help="The template to use",
)

args = parser.parse_args()

os.makedirs(args.out, exist_ok=True)

process = subprocess.run(
    [
        "jupyter-nbconvert",
        args.source,
        "--execute",
        "--no-prompt",
        # fmt: off
        "--to", "html",
        "--output", "index.html",
        "--output-dir", args.out,
        "--TemplateExporter.extra_template_basedirs", args.template.parent,
        "--template", args.template.name,
        "--TagRemovePreprocessor.remove_input_tags", "remove_cell",
        # fmt: on
    ],
)

if process.returncode > 0:
    print(f"Failed to build notebook {args.source}", file=sys.stderr)
    sys.exit(1)
