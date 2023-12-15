import { Transformer } from "@parcel/plugin";

import posthtml from "posthtml";

import { run, createEtaInstance } from "./utils.js";
import {
  postHtmlShiftHeadings,
  postHtmlAssignHeadingId,
} from "./posthtmlPlugins.js";

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
      "--HTMLExporter.exclude_anchor_links=True",
    ]);
    nbconvert_child.child.stdin?.end(source);
    const { stdout: nbconvert_result } = await nbconvert_child;

    const content = await posthtml()
      .use(postHtmlAssignHeadingId)
      .use(postHtmlShiftHeadings)
      .process(nbconvert_result);

    config.eta.resetTrackers();
    const templated = await config.eta.renderStringAsync(config.template, {
      title,
      content: content.html,
    });

    for (const path of config.eta.includedPaths) {
      asset.invalidateOnFileChange(path);
    }

    asset.setCode(templated);

    return [asset];
  },
});
