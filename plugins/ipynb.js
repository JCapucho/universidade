import { Transformer } from "@parcel/plugin";

import posthtml from "posthtml";

import {
  run,
  createEtaInstance,
  postHtmlShiftHeadings,
  postHtmlAssignHeadingId,
} from "./utils.js";
import { renderToc } from "./toc.js";

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
    const { stdout: content } = await nbconvert_child;

    const shifted = await posthtml()
      .use(postHtmlAssignHeadingId)
      .use(postHtmlShiftHeadings)
      .process(content);

    config.eta.resetTrackers();
    const templated = await config.eta.renderStringAsync(config.template, {
      title,
      content: shifted.html,
    });

    const rendered = await renderToc(templated);

    for (const path of config.eta.includedPaths) {
      asset.invalidateOnFileChange(path);
    }

    asset.type = "html";
    asset.setCode(rendered);

    return [asset];
  },
});
