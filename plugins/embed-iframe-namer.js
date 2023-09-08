import { Namer } from "@parcel/plugin";

import path from "node:path";

export default new Namer({
  name({ bundle }) {
    if (bundle.type === "embed-iframe") {
      const file = bundle.getMainEntry().filePath;
      const dir = path.dirname(file);
      const name = path.basename(file, path.extname(file));

      return `${dir}/${name}_iframe_embed.html`;
    }
    return null;
  },
});
