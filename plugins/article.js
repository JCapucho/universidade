import { Transformer } from "@parcel/plugin";

import toc from "posthtml-toc";
import posthtml from "posthtml";
import { postHtmlWrapTables } from "./posthtmlPlugins.js";

export default new Transformer({
  async transform({ asset }) {
    const templated = await asset.getCode();

    const rendered = await posthtml()
      .use(postHtmlWrapTables)
      .use(
        toc({
          title: "Tabela de Conteúdos",
          insert: { beforeChildren: ".prose" },
        }),
      )
      .process(templated);

    asset.type = "html";
    asset.setCode(rendered.html);

    return [asset];
  },
});
