import os
import argparse
from pathlib import Path

from jinja2 import Environment, FileSystemLoader, select_autoescape
from pygments import highlight
from pygments.formatters import HtmlFormatter
from pygments.lexers import guess_lexer_for_filename

parser = argparse.ArgumentParser(description="Build code file")
parser.add_argument(
    "--templates-dir",
    metavar="PATH",
    type=Path,
    help="The templates directory",
)
parser.add_argument(
    "out",
    metavar="PATH",
    type=Path,
    help="The path of the output file",
)
parser.add_argument(
    "source",
    metavar="FILE",
    type=Path,
    help="The code file",
)

args = parser.parse_args()

env = Environment(
    loader=FileSystemLoader(args.templates_dir), autoescape=select_autoescape()
)
source_template = env.get_template("source-code.jinja")


filename = args.source.name

with open(args.source) as inf:
    srcCode = inf.read()

lexer = guess_lexer_for_filename(filename, srcCode)

code = highlight(srcCode, lexer, HtmlFormatter())
source_template.stream(code=code, filename=filename, links=[]).dump(str(args.out))
