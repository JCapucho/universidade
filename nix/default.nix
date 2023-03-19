{
  lib,
  python3,
  pandoc-norg-rs,
  pandoc,
  ...
}: let
  nameToPath = path: builtins.replaceStrings ["/" " "] ["-" ""] (lib.strings.toLower path);

  transformRecursive = children: mapper: let
    mapGenerator = state: {
      name,
      children ? [],
      ...
    } @ node: let
      out = state.workdir + nameToPath name;
      childrenState = state // {workdir = out + "/";};

      mappedChildrenRes = builtins.map (mapGenerator childrenState) children;
      mappedChildren = builtins.map (res: res.map) mappedChildrenRes;
      mappedCommands = lib.strings.concatMapStringsSep "\n" (res: res.buildCommands) mappedChildrenRes;

      bNode = node // {children = mappedChildren;};

      nodeRes = mapper {
        inherit out;
        node = bNode;
      };
    in {
      map = bNode // nodeRes.meta or {};
      buildCommands =
        if nodeRes ? buildCommands
        then lib.strings.concatStringsSep "\n" [nodeRes.buildCommands mappedCommands]
        else mappedCommands;
    };

    mappedChildrenRes = builtins.map (mapGenerator {workdir = "";}) children;
  in {
    map = builtins.map (res: res.map) mappedChildrenRes;
    buildCommands = lib.strings.concatMapStringsSep "\n" (res: res.buildCommands) mappedChildrenRes;
  };

  templates = ../templates;
  pandocTemplate = ../templates/Simple.html;
  jupyterTemplate = ../templates/capucho-jupyter;

  calculateOutputPath = {
    out,
    node,
    config ? {},
  }: let
    outDir =
      if config.nestDocuments or true
      then out
      else builtins.dirOf out;
    outName =
      if config.nestDocuments or true
      then "index.html"
      else (nameToPath node.name) + ".html";
  in "${outDir}/${outName}";

  convertNorg = {
    out,
    node,
    config ? {},
  } @ args: let
    outPath = calculateOutputPath args;
  in {
    meta.href = outPath;
    buildCommands = ''
      ${pandoc-norg-rs}/bin/pandoc-norg-rs $src/'${node.target}' | ${pandoc}/bin/pandoc \
        -s --toc \
        -f 'json' \
        --metadata lang=pt-PT \
        --template '${pandocTemplate}' \
        --mathjax \
        -o $out/'${outPath}'
    '';
  };

  codePython = python3.withPackages (pyPkgs:
    with pyPkgs; [
      jinja2
      pygments
    ]);

  convertCode = {
    out,
    node,
    config ? {},
  } @ args: let
    outPath = calculateOutputPath args;
  in {
    meta.href = outPath;
    buildCommands = ''
      ${codePython}/bin/python3 ${./codeBuilder.py} \
        --templates-dir ${templates} \
        $out/'${outPath}' $src/'${node.target}'
    '';
  };

  notebookPython = python3.withPackages (pyPkgs:
    with pyPkgs; [
      numpy
      sympy
      ipykernel
      nbconvert
      matplotlib
    ]);

  convertNotebook = {
    out,
    node,
    config ? {},
  } @ args: let
    outPath = calculateOutputPath args;
  in {
    meta.href = out;
    buildCommands = ''
      ${notebookPython}/bin/jupyter-nbconvert $src/'${node.target}' \
        --execute \
        --no-prompt \
        --to html \
        --output ${builtins.baseNameOf outPath} \
        --output-dir $out/'${builtins.dirOf outPath}' \
        --TemplateExporter.extra_template_basedirs ${templates} \
        --template ${builtins.baseNameOf jupyterTemplate} \
        --TagRemovePreprocessor.remove_input_tags remove_cell
    '';
  };

  convertExternal = {
    out,
    node,
    config ? {},
  }: {
    meta.href = node.target;
    meta.external = true;
  };

  convertTyped = {
    out,
    node,
    defaultType ? null,
    extraConfig ? {},
    perTypeConfig ? {},
    preBuildCommands ? "",
    postBuildCommands ? "",
    perTypeCommands ? {},
  }: let
    type = node.type or defaultType;

    typeConfig = extraConfig // (perTypeConfig.${type} or {});
    builderCtx = {
      inherit out node;
      config = typeConfig;
    };

    base =
      if type == "norg"
      then convertNorg builderCtx
      else if type == "code"
      then convertCode builderCtx
      else if type == "external"
      then convertExternal builderCtx
      else if type == "notebook"
      then convertNotebook builderCtx
      else builtins.throw "Unknown node type ${type}";

    typeCommands = perTypeCommands.${type} or {};
  in
    if node ? target
    then
      base
      // (
        if base ? buildCommands
        then {
          buildCommands = ''
            ${preBuildCommands}
            ${typeCommands.pre or ""}
            ${base.buildCommands}
            ${typeCommands.post or ""}
            ${postBuildCommands}
          '';
        }
        else {}
      )
    else {};
in {
  inherit transformRecursive convertNorg convertCode convertExternal convertTyped;
  inherit templates pandocTemplate jupyterTemplate;
}
