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
