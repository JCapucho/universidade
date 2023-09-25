import path from "node:path";

function isIncludeDirective(obj) {
  return obj.include !== undefined;
}
function isGroupDirective(obj) {
  return obj.children !== undefined;
}
function isLinkDirective(obj) {
  return obj.link !== undefined;
}
function isSeparatorDirective(obj) {
  return obj.separator === true;
}

class MapLoader {
  constructor(config, logger) {
    this.config = config;
    this.logger = logger;
  }

  async buildGroup(name, directive, ctx) {
    const children = await this.buildChildren(directive.children, ctx);
    return {
      type: "group",
      name,
      children,
    };
  }

  async buildInclude(name, directive, ctx) {
    const mapPath = path.normalize(`${ctx.prefix}/${directive.include}`);
    const includeMap = await this.config.getConfig([mapPath]);

    if (!includeMap) this.logger.error(`Failed to include map "${mapPath}"`);

    const group = includeMap?.contents ?? { children: {} };

    return await this.buildGroup(name, group, {
      ...ctx,
      prefix: path.dirname(mapPath),
    });
  }

  async buildLink(name, link, ctx) {
    let href = link;

    try {
      // The link is a valid url do nothing to it
      const url = new URL(href);

      if (url.protocol === "embed-iframe:") {
        const pathname = path.join(ctx.prefix, url.pathname);
        href = `${url.protocol}${pathname}`;
      }
    } catch (_) {
      // Not a url assume it's a path
      if (path.isAbsolute(href)) {
        // Absolute paths are relative to the project root so
        // the leading slash is removed.
        const normalized = path.normalize(href);
        href = normalized.substring(1);
      } else {
        // Relative paths need the current context prefix added
        href = `${ctx.prefix}/${link}`;
      }
    }

    return {
      type: "link",
      name,
      href,
    };
  }

  async buildChildren(directives, ctx) {
    const hirMap = [];

    for (const [name, directive] of Object.entries(directives)) {
      if (typeof directive === "string") {
        const node = await this.buildLink(name, directive, ctx);
        hirMap.push(node);
      } else if (isLinkDirective(directive)) {
        const node = await this.buildLink(name, directive.link, ctx);
        hirMap.push(node);
      } else if (isIncludeDirective(directive)) {
        const node = await this.buildInclude(name, directive, ctx);
        hirMap.push(node);
      } else if (isGroupDirective(directive)) {
        const node = await this.buildGroup(name, directive, ctx);
        hirMap.push(node);
      } else if (isSeparatorDirective(directive)) {
        hirMap.push({
          type: "separator",
          name,
        });
      }
    }

    return hirMap;
  }
}

export async function buildMap(map, config, logger) {
  const loader = new MapLoader(config, logger);
  return await loader.buildChildren(map.content, {
    prefix: ".",
  });
}
