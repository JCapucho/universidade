{
  mkDerivation,
  helpers,
  ...
}: let
  entries = [
    {
      name = "Regressão linear";
      type = "norg";
      target = "notes/linreg.norg";
    }
    {
      name = "Cheat Sheet";
      type = "norg";
      target = "notes/cheatsheet.norg";
    }
    {
      name = "Guiões";
      children = [
        {
          name = "Prática 2";
          type = "notebook";
          target = "aula02/guião.ipynb";
        }
        {
          name = "Prática 3";
          type = "notebook";
          target = "aula03/guião.ipynb";
        }
        {
          name = "Prática 4";
          type = "notebook";
          target = "aula04/guião.ipynb";
        }
        {
          name = "Prática 5";
          type = "notebook";
          target = "aula05/guião.ipynb";
        }
        {
          name = "Prática 6";
          type = "notebook";
          target = "aula06/guião.ipynb";
        }
      ];
    }
  ];

  mapper = args:
    helpers.convertTyped (args
      // {
        extraConfig = {
          nestDocuments = false;
        };
      });

  build = helpers.transformRecursive entries mapper;
in
  mkDerivation {
    pname = "MSF";
    version = "0.1";

    dontInstall = true;

    buildPhase = ''
      runHook preBuild

      export MPLCONFIGDIR=/build/.config/matplotlib

      mkdir -p $out
      cp -r $src/notes/assets $out
      ${build.buildCommands}

      runHook postBuild
    '';

    passthru.map = build.map;

    src = ./.;
  }
