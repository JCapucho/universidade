import { Resolver } from "@parcel/plugin";

const ignored = ["/pagefind/pagefind-ui.css", "/pagefind/pagefind-ui.js"];

export default new Resolver({
  async resolve({ specifier }) {
    if (ignored.includes(specifier)) {
      return { isExcluded: true };
    }

    return null;
  },
});
