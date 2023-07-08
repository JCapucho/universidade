{
  description = "Site para os resumos da universidade";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";

    pandoc-norg-rs.url = "github:JCapucho/pandoc-norg-rs";
    pandoc-norg-rs.inputs.nixpkgs.follows = "nixpkgs";

    jupyenv.url = "github:tweag/jupyenv";
    jupyenv.inputs.nixpkgs.follows = "nixpkgs";
    jupyenv.inputs.flake-utils.follows = "flake-utils";
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
          (nodePackages.live-server.override (oldAttrs: {
            postInstall =
              (oldAttrs.postInstall or "")
              + ''
                ${dos2unix}/bin/dos2unix $out/lib/node_modules/live-server/index.js
                patch -d $out/lib/node_modules/live-server -p1 < ${./nix/live-server.patch}
              '';
          }))
          nodePackages.typescript-language-server
          nodePackages.vscode-langservers-extracted

          jupyterlab

          fswatch
        ];
      };

      packages.jupyter = jupyterlab;
      apps.jupyter.type = "app";
      apps.jupyter.program = "${jupyterlab}/bin/jupyter-lab";
    });
}
