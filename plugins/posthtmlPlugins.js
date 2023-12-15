import fs from "node:fs/promises";

import toc from "posthtml-toc";
import posthtml from "posthtml";
import { parser } from "posthtml-parser";

import { quoteattr } from "./utils.js";

import "./excalidrawSetupDom.js";

import excalidrawPkg from "@excalidraw/excalidraw";
const { loadFromBlob, exportToSvg } = excalidrawPkg;

export function processExcalidraw(asset, resolve, logger) {
  return function (tree, cb) {
    let tasks = 0;
    let finished = false;

    tree.match({ tag: "img" }, (node) => {
      try {
        const url = new URL(node.attrs.src);

        if (url.protocol !== "file" && url.protocol !== "data:") return node;
      } catch {}

      if (!node.attrs.src.endsWith(".excalidraw")) return node;

      tasks += 1;

      (async function () {
        const path = await resolve(asset.filePath, node.attrs.src, {
          specifierType: "url",
        });

        asset.invalidateOnFileChange(path);

        const buffer = await fs.readFile(path);

        let blob = new window.Blob([buffer]);

        const scene = await loadFromBlob(blob, null, null);

        scene.appState.exportBackground = false;
        const svg = await exportToSvg({
          ...scene,
          exportPadding: 20,
        });

        node.tag = "div";
        node.content = parser(svg.outerHTML);
        node.attrs = { class: "excalidraw-svg" };

        done();
      })();

      return node;
    });

    finished = true;

    if (!tasks) cb(null, tree);

    function done() {
      tasks -= 1;

      if (!tasks && finished) cb(null, tree);
    }
  };
}

export function postHtmlShiftHeadings(tree) {
  tree.match(
    [{ tag: "h1" }, { tag: "h2" }, { tag: "h3" }, { tag: "h4" }, { tag: "h5" }],
    (node) => {
      switch (node.tag) {
        case "h1":
          node.tag = "h2";
          break;
        case "h2":
          node.tag = "h3";
          break;
        case "h3":
          node.tag = "h4";
          break;
        case "h4":
          node.tag = "h5";
          break;
        case "h5":
          node.tag = "h6";
          break;
      }

      return node;
    },
  );
}

export function postHtmlAssignHeadingId(tree) {
  tree.match(
    [
      { tag: "h1" },
      { tag: "h2" },
      { tag: "h3" },
      { tag: "h4" },
      { tag: "h5" },
      { tag: "h6" },
    ],
    (node) => {
      const id = quoteattr(tree.render(node.content));
      node = Object.assign(node, { attrs: { id } });

      return node;
    },
  );
}

export function postHtmlWrapTables(tree) {
  function traverse(tree) {
    if (Array.isArray(tree)) {
      for (let i = 0; i < tree.length; i++) {
        tree[i] = traverse(tree[i]);
      }
    } else if (tree && typeof tree === "object") {
      if (tree.tag == "table") {
        return {
          tag: "div",
          attrs: {
            class: "wrapped-table",
          },
          content: [tree],
        };
      }

      if (Object.prototype.hasOwnProperty.call(tree, "content"))
        traverse(tree.content);
    }

    return tree;
  }

  traverse(tree);
}

export async function convertAllExclidraw(asset, resolve, logger, templated) {
  const rendered = await posthtml()
    .use(processExcalidraw(asset, resolve, logger))
    .process(templated);

  return rendered.html;
}
