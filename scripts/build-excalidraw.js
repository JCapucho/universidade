import path from "node:path";
import { fileURLToPath } from "node:url";
import { spawnSync } from "node:child_process";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
export const project_root = path.join(__dirname, "..");

const excalidrawDir = path.join(project_root, "excalidraw");
const excalidrawPkgDir = path.join(excalidrawDir, "src/packages/utils");

const gitRevCheck = spawnSync(
  "git",
  [
    "apply",
    "--reverse",
    "--check",
    path.join(project_root, "excalidraw.patch"),
  ],
  {
    cwd: excalidrawDir,
  },
);

if (gitRevCheck.status != 0) {
  spawnSync("git", ["apply", path.join(project_root, "excalidraw.patch")], {
    cwd: excalidrawDir,
    stdio: "inherit",
  });
} else {
  console.error("Excalidraw patch already applied");
}

let res = spawnSync("yarn", ["--frozen-lockfile"], {
  stdio: "inherit",
  cwd: excalidrawDir,
});

if (res.error) throw res.error;

res = spawnSync("yarn", ["--frozen-lockfile"], {
  stdio: "inherit",
  cwd: excalidrawPkgDir,
});

if (res.error) throw res.error;

res = spawnSync("rm", ["-rf", "dist"], {
  stdio: "inherit",
  cwd: excalidrawPkgDir,
});

if (res.error) throw res.error;

res = spawnSync("yarn", ["run", "build:umd"], {
  stdio: "inherit",
  cwd: excalidrawPkgDir,
  env: {
    NODE_ENV: "production",
  },
});

if (res.error) throw res.error;

res = spawnSync("bun", ["install", "--ignore-scripts", "--frozen-lockfile"], {
  stdio: "inherit",
});

if (res.error) throw res.error;
