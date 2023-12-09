import posthtml from "posthtml";
import toc from "posthtml-toc";

export async function renderToc(templated) {
  const rendered = await posthtml()
    .use(
      toc({
        title: "Tabela de Conteúdos",
        insert: { beforeChildren: ".prose" },
      }),
    )
    .process(templated);

  return rendered.html;
}
