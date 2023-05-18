{
  lib,
  python3,
  pandoc-norg-rs,
  pandoc,
  mkDerivation,
  ...
}: let
  templates = ../templates;
  pandocTemplate = ../templates/Simple.html;
  jupyterTemplate = ../templates/capucho-jupyter;

  generateBase = {
    src,
    name,
    prefix,
    config,
    buildPhase ? "",
    meta ? {},
  }: let
    out = "$out/${prefix}";
    callConfig = config: method:
      if config ? ${method}
      then config.${method} src out
      else "";
  in
    mkDerivation {
      inherit name meta;

      phases = ["buildPhase"];

      buildPhase = ''
        runHook preBuild

        mkdir -p "${out}"
        ${callConfig config "pre"}
        ${buildPhase}
        ${callConfig config "post"}

        runHook postBuild
      '';
    };

  convertNorg = {
    src,
    name,
    prefix,
    config,
  }:
    generateBase
    {
      inherit src name prefix config;
      meta.href = "${prefix}/${config.fileName or "index.html"}";

      buildPhase = ''
        ${pandoc-norg-rs}/bin/pandoc-norg-rs "${src}" | ${pandoc}/bin/pandoc \
          -s --toc \
          -f 'json' \
          --metadata lang=pt-PT \
          --template '${pandocTemplate}' \
          --mathjax \
          -o "$out/${prefix}/${config.fileName or "index.html"}"
      '';
    };

  codePython = python3.withPackages (pyPkgs:
    with pyPkgs; [
      jinja2
      pygments
    ]);

  convertCode = {
    src,
    name,
    prefix,
    config,
  }:
    generateBase {
      inherit src name prefix config;
      meta.href = "${prefix}/${config.fileName or "index.html"}";

      buildPhase = ''
        ${codePython}/bin/python3 ${./codeBuilder.py} \
          --templates-dir ${templates} \
          "$out/${prefix}/${config.fileName or "index.html"}" "${src}"
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
    src,
    name,
    prefix,
    config,
  }:
    generateBase {
      inherit src name prefix config;

      meta.href = "${prefix}/${config.fileName or "index.html"}";

      buildPhase = ''
        ${notebookPython}/bin/jupyter-nbconvert "${src}" \
          --execute \
          --no-prompt \
          --to html \
          --output ${config.fileName or "index.html"} \
          --output-dir "$out/${prefix}" \
          --TemplateExporter.extra_template_basedirs ${templates} \
          --template ${builtins.baseNameOf jupyterTemplate} \
          --TagRemovePreprocessor.remove_input_tags remove_cell
      '';
    };

  convertExternal = {
    src,
    name,
    prefix,
    config,
  }:
    generateBase {
      inherit src name prefix config;

      meta.href = src;
      meta.external = true;
    };

  buildGroup = {
    src,
    name,
    prefix,
    config,
  } @ args:
    generateBase args;

  convertTyped = {
    node,
    prefix,
    config,
  }: let
    type = node.type or "group";
    src = node.src;
    name = node.name;

    thisConfig =
      lib.recursiveUpdate
      config
      config.perTypeConfig.${type} or {};
    builderCtx = {
      inherit src name prefix;
      config = thisConfig;
    };

    builderTypeMapping =
      {
        norg = convertNorg;
        code = convertCode;
        external = convertExternal;
        notebook = convertNotebook;
        group = buildGroup;
      }
      // (thisConfig.extraTypes or {});

    builder = builderTypeMapping.${type};
  in
    builder builderCtx;
in {
  inherit convertTyped generateBase;
  inherit templates pandocTemplate jupyterTemplate;
}
