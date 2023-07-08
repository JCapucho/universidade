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
  helpers = helperCallPackage ./nix {callPackage = helperCallPackage;};
  mapCallPackage = pkgs.newScope (overrides // {helpers = helpers.builders;});

  modules = [
    (mapCallPackage ./FP {})
    (mapCallPackage ./ITW {})
    (mapCallPackage ./MAS {})
    (mapCallPackage ./maps/ALGA.nix {})
    (mapCallPackage ./maps/CalcI.nix {})
    (mapCallPackage ./maps/CalcII.nix {})
    (mapCallPackage ./maps/MD.nix {})
    (mapCallPackage ./MSF {})
    (mapCallPackage ./IAC {})
  ];

  moduleDrvs = helpers.buildRoot modules;

  map = {
    title = "Resumos Universidade";
    author = "João Capucho";
    description = "Resumos para as unidades curriculares da Licenciatura de Engenharia Informática da universidade de aveiro";

    content = builtins.map (module: module.meta.map) moduleDrvs;
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

      ${pkgs.lib.concatMapStringsSep "\n" (
          module: "ln -s '${module}/${module.meta.map.shorthand}' $out/'${module.meta.map.shorthand}'"
        )
        moduleDrvs}

      ${python}/bin/python3 ${./nix/build.py} \
        --map "$out/map.json" \
        --build-dir "$out"

      cp "${./nix/robots.txt}" "$out/robots.txt"

      runHook postBuild
    '';

    src = ./.;
  }
