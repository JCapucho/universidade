{
  mkDerivation,
  helpers,
  ...
}: let
  entries = [
    {
      name = "Cheat Sheet";
      type = "norg";
      target = "notes/cheatsheet.norg";
    }
    {
      name = "Regressão linear";
      type = "norg";
      target = "notes/linreg.norg";
    }
    {
      name = "Método de Euler";
      type = "norg";
      target = "notes/euler.norg";
    }
    {
      name = "Forças";
      type = "norg";
      target = "notes/forces.norg";
    }
    {
      name = "Energia e Trabalho";
      type = "norg";
      target = "notes/work.norg";
    }
    {
      name = "Integração numérica";
      type = "norg";
      target = "notes/int.norg";
    }
    {
      name = "Slides teóricos";
      type = "external";
      target = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/EiBQ_4gRz79Mq-MdPpM4stwBCvhJ7tiaxazbuxOObDiK1A?e=ycMBJ5";
    }
    {
      name = "Guiões";
      children = [
        {
          name = "Guiões";
          type = "external";
          target = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/Etzx87VMIY5Hgc_nZyznkp4Bsr6TBWCkq2nJxRv2VW_sQg?e=e23jka";
        }
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
        {
          name = "Prática 7";
          type = "notebook";
          target = "aula07/guião.ipynb";
        }
        {
          name = "Prática 8";
          type = "notebook";
          target = "aula08/guião.ipynb";
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
