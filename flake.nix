{
  description = "Site para os resumos da universidade";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    pandoc-norg-rs.url = "github:JCapucho/pandoc-norg-rs";
    pandoc-norg-rs.inputs.nixpkgs.follows = "nixpkgs";

    jupyenv.url = "github:tweag/jupyenv";
  };
  outputs = {
    nixpkgs,
    flake-utils,
    pandoc-norg-rs,
    jupyenv,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      inherit (jupyenv.lib.${system}) mkJupyterlabNew;
      jupyterlab = mkJupyterlabNew ({...}: {
        nixpkgs = nixpkgs;
        imports = [
          ({pkgs, ...}: {
            kernel.python.minimal = {
              enable = true;
            };
          })
        ];
      });

      python-packages = python-packages:
        with python-packages; [
          numpy
          sympy
          jinja2
          aiofiles
          matplotlib
          beautifulsoup4
          pygments
        ];
      python = pkgs.python3.withPackages (pyPkgs:
        (python-packages pyPkgs)
        ++ [
          pyPkgs.ipykernel
          pyPkgs.nbconvert
        ]);
      python-dev =
        pkgs.python3.withPackages
        (pyPkgs: (python-packages pyPkgs) ++ [pyPkgs.snakeviz]);

      sharedPackages = with pkgs; [
        ghostscript
        imagemagick
        pandoc
        pandoc-norg-rs.packages.${system}.default
      ];
    in {
      packages.default = pkgs.stdenv.mkDerivation {
        pname = "export";
        version = "0.1";

        buildInputs = sharedPackages ++ [python];

        dontInstall = true;

        buildPhase = ''
          runHook preBuild

          shopt -s globstar

          mkdir -p $out

          export MPLCONFIGDIR=/build/.config/matplotlib

          for i in **/*.py; do
            substituteInPlace "$i" \
              --replace "/usr/bin/env python3" "${python}/bin/python3"
          done

          ./build.py --build-dir $out

          cp robots.txt $out

          runHook postBuild
        '';

        src = ./.;
      };

      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs;
          [
            # Python
            black
            python-dev
            nodePackages.pyright

            # Java
            jdk
            jdt-language-server

            # .Net
            dotnet-sdk

            # Node
            nodejs
            nodePackages.serve
            nodePackages.typescript-language-server
            nodePackages.vscode-langservers-extracted

            jupyterlab
          ]
          ++ sharedPackages;
      };

      packages.jupyter = jupyterlab;
      apps.jupyter.type = "app";
      apps.jupyter.program = "${jupyterlab}/bin/jupyter-lab";
    });
}
