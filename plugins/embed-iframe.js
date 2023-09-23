import { Transformer } from "@parcel/plugin";

import path from "node:path";
import { createEtaInstance } from "./utils.js";
import { parser } from "posthtml-parser";
import Api from "posthtml/lib/api.js";

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
    const code = await asset.getCode();
    const ast = parser(code);

    Api.call(ast);

    let title = undefined;
    ast.match({ tag: "title" }, (node) => {
      title = node.content[0];
      return node;
    });

    config.eta.resetTrackers();
    const result = await config.eta.renderStringAsync(config.template, {
      title,
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
