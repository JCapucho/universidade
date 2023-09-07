import { Transformer } from "@parcel/plugin";

import { eta } from "./utils.js";
import { buildMap } from "./maploader.js";

export default new Transformer({
  async loadConfig({ config, logger }) {
    const rootMap = await config.getConfig(["./root.toml"]);

    if (!rootMap) {
      logger.error("No root map was provided");
      return;
    }

    const map = await buildMap(rootMap.contents, config, logger);

    return { map };
  },
  async transform({ asset, config }) {
    const map = config?.map ?? [];
    const source = await asset.getCode();

    const result = await eta.renderStringAsync(source, { map });
    asset.type = "html";
    asset.setCode(result);

    return [asset];
  },
});
