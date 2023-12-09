import util from "node:util";
import path from "node:path";
import { fileURLToPath } from "node:url";
import child_process from "node:child_process";

import { Eta } from "eta";

const execFile = util.promisify(child_process.execFile);

export function run(command, args) {
  return execFile(command, args, { maxBuffer: 100 * 1024 * 1024 });
}

const __dirname = path.dirname(fileURLToPath(import.meta.url));
export const project_root = path.join(__dirname, "..");

class CustomEta extends Eta {
  includedPaths = new Set();

  constructor(options) {
    super(options);

    const oldReadFile = this.readFile;

    this.readFile = function (path) {
      this.includedPaths.add(path);
      return oldReadFile(path);
    };
  }

  resetTrackers() {
    this.includedPaths.clear();
  }
}

export function createEtaInstance() {
  return new CustomEta({ views: path.join(project_root, "templates") });
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

// Source: https://stackoverflow.com/a/9756789
function quoteattr(s, preserveCR) {
  preserveCR = preserveCR ? "&#13;" : "\n";
  return (
    ("" + s) /* Forces the conversion to string. */
      .replace(/&/g, "&amp;") /* This MUST be the 1st replacement. */
      .replace(/'/g, "&apos;") /* The 4 other predefined entities, required. */
      .replace(/"/g, "&quot;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      /*
        You may add other replacements here for HTML only 
        (but it's not necessary).
        Or for XML, only if the named entities are defined in its DTD.
        */
      .replace(/\r\n/g, preserveCR) /* Must be before the next replacement. */
      .replace(/[\r\n]/g, preserveCR)
  );
}
