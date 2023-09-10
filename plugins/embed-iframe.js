import { Transformer } from "@parcel/plugin";

import path from "node:path";

import { createEtaInstance } from "./utils.js";

export default new Transformer({
  async loadConfig({ config }) {
    const loadedTemplate = await config.getConfig(
      ["./templates/embed_iframe.eta"],
      { parse: false },
    );
    let template = loadedTemplate?.contents;

    const eta = createEtaInstance();

    if (!loadedTemplate) {
      logger.error("Failed to load norg template");
      template = "ERROR LOADING TEMPLATE";
    }

    return { eta, template };
  },
  async transform({ asset, config }) {
    config.eta.resetTrackers();
    const result = await config.eta.renderStringAsync(config.template, {
      url: path.basename(asset.filePath),
    });

    for (const path of config.eta.includedPaths) {
      asset.invalidateOnFileChange(path);
    }

    asset.type = "embed-iframe";
    asset.setCode(result);

    return [asset];
  },
});
