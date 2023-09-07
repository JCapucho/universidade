{
  description = "Site para os resumos da universidade";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
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
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      inherit (jupyenv.lib.${system}) mkJupyterlabNew;
      jupyterlab = mkJupyterlabNew ({...}: {
        nixpkgs = nixpkgs;
        imports = [
          ({pkgs, ...}: {
            kernel.python.minimal = {
              enable = true;
              # extraPackages = ps: [ps.ipympl];
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
            ipykernel
            nbconvert
            snakeviz
          ]);
    in {
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
          nodePackages.pnpm
          nodePackages.prettier
          nodePackages.typescript-language-server
          nodePackages.vscode-langservers-extracted
          nodePackages."@tailwindcss/language-server"
        ];
      };

      packages.jupyter = jupyterlab;
      apps.jupyter.type = "app";
      apps.jupyter.program = "${jupyterlab}/bin/jupyter-lab";
    });
}
