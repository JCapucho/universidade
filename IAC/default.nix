{
  mkDerivation,
  helpers,
  ...
}: let
  entries = [
    {
      name = "Representação digital de informação";
      type = "norg";
      target = "repr-digital.norg";
    }
    {
      name = "Lógica binária e Circuitos";
      type = "norg";
      target = "binary-logic.norg";
    }
    {
      name = "Blocos combinatórios";
      type = "norg";
      target = "combinatorios.norg";
    }
    {
      name = "Circuitos sequenciais";
      type = "norg";
      target = "sequenciais.norg";
    }
    {
      name = "Arquitetura de computadores";
      type = "norg";
      target = "arquitetura-de-computadores.norg";
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
    pname = "IAC";
    version = "0.1";

    dontInstall = true;

    buildPhase = ''
      runHook preBuild

      mkdir -p $out
      cp -r $src/assets $out/assets
      ${build.buildCommands}

      runHook postBuild
    '';

    passthru.map = build.map;

    src = ./.;
  }
