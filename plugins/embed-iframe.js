import { Transformer } from "@parcel/plugin";

import { readFile } from "node:fs/promises";
import path from "node:path";

import { eta } from "./utils.js";

export default new Transformer({
  async loadConfig({ config }) {
    const templateFile = "./templates/embed_iframe.eta";
    const template = await readFile(templateFile, { encoding: "utf8" });

    config.invalidateOnFileChange(templateFile);

    return { template };
  },
  async transform({ asset, config }) {
    const result = await eta.renderStringAsync(config.template, {
      url: path.basename(asset.filePath),
    });
    asset.type = "embed-iframe";
    asset.setCode(result);

    return [asset];
  },
});
