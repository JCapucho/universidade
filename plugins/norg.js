import { Transformer } from "@parcel/plugin";

import { run, createEtaInstance } from "./utils.js";

export default new Transformer({
  async loadConfig({ config }) {
    const loadedTemplate = await config.getConfig(["./templates/norg.eta"], {
      parse: false,
    });
    let template = loadedTemplate?.contents;

    const eta = createEtaInstance();

    if (!loadedTemplate) {
      logger.error("Failed to load norg template");
      template = "ERROR LOADING TEMPLATE";
    }

    return { eta, template };
  },
  async transform({ asset, config }) {
    const sourcePath = await asset.getCode();

    const norg_rs_child = run("pandoc-norg-rs");
    norg_rs_child.child.stdin?.end(sourcePath);
    const { stdout: pandoc_json } = await norg_rs_child;

    const title = JSON.parse(pandoc_json).meta.title.c;
    const pandoc_child = run("pandoc", [
      "-f",
      "json",
      "--mathjax",
      "--metadata",
      "lang=pt-PT",
    ]);
    pandoc_child.child.stdin?.end(pandoc_json);
    const { stdout: content } = await pandoc_child;

    config.eta.resetTrackers();
    const result = await config.eta.renderStringAsync(config.template, {
      title,
      content,
    });

    for (const path of config.eta.includedPaths) {
      asset.invalidateOnFileChange(path);
    }

    asset.type = "html";
    asset.setCode(result);

    return [asset];
  },
});
