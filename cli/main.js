import { Parcel } from "@parcel/core";

import yargs from "yargs";
import { hideBin } from "yargs/helpers";
import { fileURLToPath } from "node:url";

async function createParcel(dev, debug) {
  let bundler = new Parcel({
    entries: "index.eta",
    defaultConfig: "./parcelrc",
    mode: dev ? "development" : "production",
    logLevel: debug ? "verbose" : "info",
    // targets: ["modern"],
    env: {
      NODE_ENV: dev ? "development" : "production",
    },
    additionalReporters: [
      {
        packageName: "@parcel/reporter-cli",
        resolveFrom: fileURLToPath(import.meta.url),
      },
    ],
    serveOptions: dev
      ? {
          port: 3000,
        }
      : undefined,
    hmrOptions: dev
      ? {
          port: 3000,
        }
      : undefined,
  });

  return bundler;
}

async function startBuild(argv) {
  const bundler = await createParcel(false, argv.debug);

  let { changedAssets } = await bundler.run();
  if (argv.debug) console.log(changedAssets);
}

async function startDevServer(argv) {
  const bundler = await createParcel(true, argv.debug);

  bundler.watch((err, event) => {
    if (err) {
      // fatal error
      throw err;
    }

    if (event?.type === "buildSuccess") {
      if (argv.debug) console.log(event.changedAssets);
    }
  });
}

yargs(hideBin(process.argv))
  .scriptName("uni-builder")
  .option("debug", {
    describe: "Enables extra debug output",
    type: "boolean",
  })
  .command(
    ["dev", "$0"],
    "Starts the uni-builder dev server",
    () => {},
    startDevServer,
  )
  .command("build", "Builds for production", () => {}, startBuild)
  .strict()
  .help("help").argv;
