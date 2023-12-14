import { Namer } from "@parcel/plugin";

import path from "node:path";

export default new Namer({
  name({ bundle, bundleGraph }) {
    const main_entry = bundle.getMainEntry();

    if (main_entry === null) return null;

    if (main_entry.meta?.is_uni_embed_iframe) {
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
