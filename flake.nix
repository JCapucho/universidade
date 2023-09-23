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

      base-py-pkgs = pyPkgs:
        with pyPkgs; [
          numpy
          sympy
          matplotlib
          ipykernel
          nbconvert
        ];

      python-dev = pkgs.python3.withPackages base-py-pkgs;

      buildSite = pkgs.writeScriptBin "build-site" ''
        bun install
        bun run build
      '';

      base-pkgs = with pkgs; [
        bun
        nodejs
        pandoc
        pandoc-norg-rs.packages.${system}.default
        (pkgs.python3.withPackages base-py-pkgs)
      ];
    in {
      devShells.prod = pkgs.mkShell {
        buildInputs = base-pkgs ++ [buildSite];
      };

      devShells.default = pkgs.mkShell {
        buildInputs =
          base-pkgs
          ++ (with pkgs; [
            bear
            clang-tools

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
            nodePackages.prettier
            nodePackages.typescript-language-server
            nodePackages.vscode-langservers-extracted
            nodePackages."@tailwindcss/language-server"
          ]);
      };

      packages.jupyter = jupyterlab;
      apps.jupyter.type = "app";
      apps.jupyter.program = "${jupyterlab}/bin/jupyter-lab";
    });
}
