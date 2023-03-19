{
  pkgs,
  system,
  pandoc-norg-rs,
}: let
  overrides = {
    mkDerivation = pkgs.stdenv.mkDerivation;
    pandoc-norg-rs =
      pandoc-norg-rs.packages.${system}.default;
  };
  helperCallPackage = pkgs.newScope overrides;
  helpers = helperCallPackage ./nix {};
  mapCallPackage = pkgs.newScope (overrides // {helpers = helpers;});

  modules = [
    rec {
      name = "Fundamentos da Programação";
      shorthand = "FP";
      drv = mapCallPackage ./FP {};
      map = drv.passthru.map;
    }
    rec {
      name = "Introdução as tecnologias web";
      shorthand = "ITW";
      drv = mapCallPackage ./ITW {};
      map = drv.passthru.map;
    }
    {
      name = "Modelação e análise de sistemas";
      shorthand = "MAS";
      map = mapCallPackage ./MAS {};
    }
    {
      name = "Cálculo II";
      shorthand = "CII";
      map = mapCallPackage ./nix/CalcII.nix {};
    }
    rec {
      name = "Modelação de Sistemas Físicos";
      shorthand = "MSF";
      drv = mapCallPackage ./MSF {};
      map = drv.passthru.map;
    }
    {
      name = "Matemática Discreta";
      shorthand = "MD";
      map = mapCallPackage ./nix/MD.nix {};
    }
  ];

  patchModuleMap = prefix: {
    href ? null,
    external ? false,
    children,
    ...
  } @ map:
    map
    // {
      children = builtins.map (patchModuleMap prefix) children;
    }
    // (
      if href != null
      then {
        href =
          if external
          then href
          else "${prefix}/${href}";
      }
      else {}
    );

  content =
    builtins.map (module: {
      name = module.name;
      children = builtins.map (patchModuleMap module.shorthand) module.map;
    })
    modules;

  map = {
    title = "Resumos Universidade";
    author = "João Capucho";
    description = "Resumos para as unidades curriculares da Licenciatura de Engenharia Informática da universidade de aveiro";

    inherit content;
  };

  python = pkgs.python3.withPackages (pyPkgs:
    with pyPkgs; [
      jinja2
      pygments
    ]);
in
  pkgs.stdenv.mkDerivation {
    pname = "export";
    version = "0.1";

    dontInstall = true;

    buildPhase = ''
      runHook preBuild

      mkdir -p $out

      cp -r $src/resources $out/resources

      echo -n '${builtins.toJSON map}' > "$out/map.json"

      ${pkgs.lib.concatMapStringsSep "\n" (module:
        if module ? drv
        then "ln -s '${module.drv}' $out/'${module.shorthand}'"
        else "")
      modules}

      ${python}/bin/python3 ${./nix/build.py} \
        --map "$out/map.json" \
        --build-dir "$out"

      cp ${./nix/robots.txt} $out

      runHook postBuild
    '';

    src = ./.;
  }
