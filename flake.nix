{
  description = "Site para os resumos da universidade";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    pandoc-norg-rs.url = "github:JCapucho/pandoc-norg-rs";
    pandoc-norg-rs.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {
    nixpkgs,
    flake-utils,
    pandoc-norg-rs,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      python-packages = python-packages:
        with python-packages; [
          numpy
          sympy
          jinja2
          matplotlib
          beautifulsoup4
          pygments
        ];
      python = pkgs.python3.withPackages python-packages;
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

        buildInputs = sharedPackages;

        dontInstall = true;

        buildPhase = ''
          runHook preBuild

          mkdir -p $out

          shopt -s globstar

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
          ]
          ++ sharedPackages;
      };
    });
}
