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

      python-dev =
        pkgs.python3.withPackages
        (pyPkgs:
          with pyPkgs; [
            numpy
            sympy
            jinja2
            aiofiles
            matplotlib
            beautifulsoup4
            pygments
            snakeviz
          ]);
    in {
      packages.default = import ./default.nix {inherit pkgs system pandoc-norg-rs;};

      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          pandoc
          ghostscript
          imagemagick
          pandoc-norg-rs.packages.${system}.default

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
        ];
      };

      packages.jupyter = jupyterlab;
      apps.jupyter.type = "app";
      apps.jupyter.program = "${jupyterlab}/bin/jupyter-lab";
    });
}
