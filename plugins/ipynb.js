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

  async transform({ config, asset }) {
    const source = await asset.getCode();

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

    const code = await eta.renderStringAsync(config.template, { content });

    asset.type = "html";
    asset.setCode(code);

    return [asset];
  },
});
