import { Transformer } from "@parcel/plugin";

import { run, createEtaInstance } from "./utils.js";

export default new Transformer({
  async loadConfig({ config }) {
    const loadedTemplate = await config.getConfig(["./templates/ipynb.eta"], {
      parse: false,
    });
    let template = loadedTemplate?.contents;

    const eta = createEtaInstance();

    if (!template) {
      logger.error("Failed to load norg template");
      template = "ERROR LOADING TEMPLATE";
    }

    return { eta, template };
  },

  async transform({ config, asset }) {
    const source = await asset.getCode();

    const title = JSON.parse(source).metadata.title;

    const nbconvert_child = run("jupyter-nbconvert", [
      "--stdin",
      "--stdout",
      "--execute",
      "--no-prompt",
      "--to=html",
      "--template=basic",
      "--TagRemovePreprocessor.remove_input_tags=remove_cell",
    ]);
    nbconvert_child.child.stdin?.end(source);
    const { stdout: content } = await nbconvert_child;

    config.eta.resetTrackers();
    const code = await config.eta.renderStringAsync(config.template, {
      title,
      content,
    });

    for (const path of config.eta.includedPaths) {
      asset.invalidateOnFileChange(path);
    }

    asset.type = "html";
    asset.setCode(code);

    return [asset];
  },
});
