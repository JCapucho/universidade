#!/usr/bin/env python3
import os
import bs4
import glob
import shutil
import argparse

from pathlib import Path
from dataclasses import dataclass
from urllib.parse import urlparse

from pygments import highlight
from jinja2 import Environment, FileSystemLoader, select_autoescape

from pygments.lexer import Lexer
from pygments.lexers import HtmlLexer, guess_lexer_for_filename
from pygments.formatters import HtmlFormatter


# Find the directory of the script and normalize it
# (set strict=True because we want to verify the file exists)
script_dir = Path(__file__).resolve(True).parent

parser = argparse.ArgumentParser(description="Build ITW")
parser.add_argument(
    "--template-dir",
    metavar="PATH",
    type=Path,
    help="The template directory to use",
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

os.makedirs(args.out / "raw", exist_ok=True)
shutil.copytree(args.source, args.out, dirs_exist_ok=True)
shutil.copytree(args.source.parent / "lib", args.out.parent / "lib", dirs_exist_ok=True)

env = Environment(
    loader=FileSystemLoader(args.template_dir), autoescape=select_autoescape()
)
sourceTemplate = env.get_template("source.jinja")
navbarTemplate = env.get_template("navbar.jinja")

src_path = Path(args.source).resolve()


@dataclass
class Source:
    rel_path: Path
    path: Path
    lexer: Lexer | None = None

    @property
    def href(self) -> Path:
        if self.rel_path.suffix == ".html":
            return self.rel_path
        else:
            return Path(str(self.rel_path) + ".html")

    def getLexer(self, srcCode) -> Lexer:
        if self.lexer is not None:
            return self.lexer
        else:
            return guess_lexer_for_filename(self.rel_path, srcCode)

    def build(self, sources, rootName):
        with open(self.path) as inf:
            srcCode = inf.read()

        walkUp = len(self.rel_path.parents)
        root = "../" * walkUp + rootName

        code = highlight(srcCode, self.getLexer(srcCode), HtmlFormatter())
        sourceTemplate.stream(
            code=code, filename=self.rel_path, links=sources, root=root
        ).dump(str(args.out / "raw" / self.href))


def processSource(src, rootName, sources):
    path = Path(str(src))
    full_path = (src_path / path).resolve()
    if path.is_absolute() or not (src_path in full_path.parents):
        return

    name = full_path.relative_to(src_path)

    sources.append(Source(name, full_path))


def processPage(filename):
    with open(src_path / filename) as inf:
        txt = inf.read()
        soup = bs4.BeautifulSoup(txt, features="lxml")

    sources = [Source(Path(filename), src_path / filename, HtmlLexer())]

    for link_node in soup.find_all("link"):
        sheet = link_node.get("href")
        if urlparse(sheet).scheme == "":
            processSource(sheet, filename, sources)

    for link_node in soup.find_all("script"):
        script = link_node.get("src")
        if urlparse(script).scheme == "":
            processSource(script, filename, sources)

    navbar = navbarTemplate.render(title=args.title, filename=filename)
    fragment = bs4.BeautifulSoup(navbar, features="lxml")
    soup.body.insert(0, fragment)

    with open(args.out / filename, "w") as outf:
        outf.write(str(soup))

    for src in sources:
        src.build(sources, filename)


for file in glob.glob("*.html", root_dir=args.source):
    processPage(file)
