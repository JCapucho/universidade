#!/usr/bin/env python3
import os
import bs4
import glob
import shutil
import argparse
from pathlib import Path
from pygments import highlight
from pygments.lexers import HtmlLexer
from pygments.formatters import HtmlFormatter
from jinja2 import Environment, FileSystemLoader, select_autoescape

# Find the directory of the script and normalize it
# (set strict=True because we want to verify the file exists)
script_dir = Path(__file__).resolve(True).parent

parser = argparse.ArgumentParser(description="Build ITW")
parser.add_argument(
    "source",
    metavar="FILE",
    type=Path,
    help="The source neorg file",
)
parser.add_argument(
    "out",
    metavar="PATH",
    type=Path,
    help="The partial path (without extension) to the output file",
)
parser.add_argument(
    "--template-dir",
    metavar="PATH",
    type=Path,
    help="The template directory to use",
)
parser.add_argument(
    "title",
    metavar="TITLE",
    type=str,
    help="The title of the page",
)

args = parser.parse_args()

os.makedirs(args.out / "raw", exist_ok=True)
shutil.copytree(args.source, args.out, dirs_exist_ok=True)

env = Environment(
    loader=FileSystemLoader(args.template_dir), autoescape=select_autoescape()
)
sourceTemplate = env.get_template("source.jinja")
navbarTemplate = env.get_template("navbar.jinja")


def addNavigationBar(filename):
    with open(args.source / filename) as inf:
        txt = inf.read()
        soup = bs4.BeautifulSoup(txt, features="lxml")
        code = highlight(txt, HtmlLexer(), HtmlFormatter())
        sourceTemplate.stream(code=code, filename=filename).dump(
            str(args.out / "raw" / filename)
        )

    navbar = navbarTemplate.render(title=args.title, filename=filename)
    fragment = bs4.BeautifulSoup(navbar, features="lxml")
    soup.body.insert(0, fragment)

    with open(args.out / filename, "w") as outf:
        outf.write(str(soup))


for file in glob.glob("*.html", root_dir=args.source):
    addNavigationBar(file)
