import { Namer } from "@parcel/plugin";

import path from "node:path";

export default new Namer({
  name({ bundle, bundleGraph }) {
    if (bundle.type === "embed-iframe") {
      const file = bundle.getMainEntry().filePath;
      const name = path.basename(file, path.extname(file));

      const entryRoot = bundleGraph.getEntryRoot(bundle.target);

      return path
        .join(
          path.relative(entryRoot, path.dirname(file)),
          `${name}_iframe_embed.html`,
        )
        .replace(/\.\.(\/|\\)/g, "up_$1");
    }
    return null;
  },
});
