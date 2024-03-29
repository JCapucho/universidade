import { Transformer } from "@parcel/plugin";

import { run, createEtaInstance } from "./utils.js";
import { convertAllExclidraw } from "./posthtmlPlugins.js";

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
  async transform({ asset, resolve, config, logger }) {
    const sourcePath = await asset.getCode();

    const norg_rs_child = run("pandoc-norg-rs");
    norg_rs_child.child.stdin?.end(sourcePath);
    const { stdout: pandoc_json } = await norg_rs_child;

    const title = JSON.parse(pandoc_json).meta.title.c;
    const pandoc_child = run("pandoc", [
      "-f",
      "json",
      "--shift-heading-level-by=1",
      "--mathjax",
      "--metadata",
      "lang=pt-PT",
    ]);
    pandoc_child.child.stdin?.end(pandoc_json);
    const { stdout: pandoc_result } = await pandoc_child;

    const content = await convertAllExclidraw(
      asset,
      resolve,
      logger,
      pandoc_result,
    );

    config.eta.resetTrackers();
    const templated = await config.eta.renderStringAsync(config.template, {
      title,
      content,
    });

    for (const path of config.eta.includedPaths) {
      asset.invalidateOnFileChange(path);
    }

    asset.setCode(templated);

    return [asset];
  },
});
