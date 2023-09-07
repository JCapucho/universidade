import { Transformer } from "@parcel/plugin";

import { readFile } from "node:fs/promises";

import { run, eta } from "./utils.js";

export default new Transformer({
  async loadConfig({ config }) {
    const templateFile = "./templates/norg.eta";
    const template = await readFile(templateFile, { encoding: "utf8" });

    config.invalidateOnFileChange(templateFile);

    return { template };
  },
  async transform({ asset, config }) {
    const sourcePath = await asset.getCode();

    const norg_rs_child = run("pandoc-norg-rs");
    norg_rs_child.child.stdin?.end(sourcePath);
    const { stdout: pandoc_json } = await norg_rs_child;

    const pandoc_child = run("pandoc", [
      "-f",
      "json",
      "--toc",
      "--metadata",
      "lang=pt-PT",
    ]);
    pandoc_child.child.stdin?.end(pandoc_json);
    const { stdout: content } = await pandoc_child;

    const result = await eta.renderStringAsync(config.template, { content });

    asset.type = "html";
    asset.setCode(result);

    return [asset];
  },
});
