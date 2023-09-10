import { Transformer } from "@parcel/plugin";

import { createEtaInstance } from "./utils.js";
import { buildMap } from "./maploader.js";

export default new Transformer({
  async loadConfig({ config, logger }) {
    const rootMap = await config.getConfig(["./root.toml"]);

    if (!rootMap) {
      logger.error("No root map was provided");
      return { map: [] };
    }

    const eta = createEtaInstance();
    const map = await buildMap(rootMap.contents, config, logger);

    return { eta, map };
  },
  async transform({ asset, config }) {
    const source = await asset.getCode();

    config.eta.resetTrackers();
    const result = await config.eta.renderStringAsync(source, {
      map: config.map,
    });

    for (const path of config.eta.includedPaths) {
      asset.invalidateOnFileChange(path);
    }

    asset.type = "html";
    asset.setCode(result);

    return [asset];
  },
});
