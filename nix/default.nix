{
  lib,
  symlinkJoin,
  callPackage,
  ...
}: let
  builders = callPackage ./builders.nix {};

  nameToPath = path: builtins.replaceStrings ["/" " "] ["-" ""] (lib.strings.toLower path);

  calculatePrefix = {
    name,
    config,
    prefix,
  }:
    if config.nestDocuments or true
    then "${prefix}/${nameToPath name}"
    else prefix;

  calculateChildconfig = {
    name,
    config,
    thisConfig,
  }:
    (builtins.removeAttrs config ["this"])
    // (
      if thisConfig.nestDocuments or true
      then {}
      else {this.fileName = "${name}.html";}
    );

  build = {
    prefix,
    config,
  }: node: let
    thisConfig' =
      lib.recursiveUpdate config
      node.config or {};
    thisConfig =
      lib.recursiveUpdate thisConfig'
      thisConfig'.this or {};

    drv = builders.convertTyped {
      inherit node prefix;
      config = thisConfig;
    };

    children = node.children or [];
    childBuild = node:
      build {
        prefix = calculatePrefix {
          inherit prefix;
          name = node.name;
          config = thisConfig;
        };
        config = calculateChildconfig {
          inherit thisConfig;
          name = node.name;
          config = thisConfig';
        };
      }
      node;
    childrenDrvs = builtins.map childBuild children;
  in
    symlinkJoin {
      name = node.name;
      paths = [drv] ++ childrenDrvs;
      meta.map =
        (drv.meta.props or {})
        // {
          name = node.name;
          children = builtins.map (child: child.meta.map) childrenDrvs;
        };
    };

  moduleBuild = module: let
    modConfig = module.config or {};
    thisConfig =
      lib.recursiveUpdate modConfig
      modConfig.this or {};

    children = builtins.map (node:
      build {
        prefix = calculatePrefix {
          prefix = module.shorthand;
          name = node.name;
          config = modConfig.this or {};
        };
        config = calculateChildconfig {
          inherit thisConfig;
          name = node.name;
          config = modConfig;
        };
      }
      node)
    module.map;

    modDrv = builders.generateBase {
      src = null;
      name = module.name;
      prefix = module.shorthand;
      config = modConfig.this or {};
    };
  in
    symlinkJoin {
      name = module.name;
      paths = [modDrv] ++ children;
      meta.map = {
        inherit (module) name shorthand;
        children = builtins.map (child: child.meta.map) children;
      };
    };

  buildRoot = modules:
    builtins.map moduleBuild
    modules;
in {
  inherit buildRoot builders;
}
