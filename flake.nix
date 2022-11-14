{
  description = "Site para os resumos da universidade";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    neorg-pandoc-src.url = "github:JCapucho/neorg-haskell-parser";
    # neorg-pandoc-src.url = "path:///home/capucho/programming/neorg-haskell-parser";
    neorg-pandoc-src.flake = false;
  };
  outputs = {
    nixpkgs,
    flake-utils,
    neorg-pandoc-src,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      hCallPackage = pkgs.haskellPackages.callPackage;
      neorg-pandoc = hCallPackage ./nix/neorg-pandoc.nix {
        inherit neorg-pandoc-src;
      };

      python-packages = python-packages:
        with python-packages; [
          jinja2
          matplotlib
          beautifulsoup4
          pygments
        ];
      python = pkgs.python3.withPackages python-packages;

      sharedPackages = with pkgs; [
        python
        ghostscript
        imagemagick
        pandoc
        neorg-pandoc
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
          python3 ./build.py --build-dir $out

          runHook postBuild
        '';

        src = ./.;
      };
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs;
          [
            black
            python3Packages.python-lsp-server
            dotnet-sdk
            jdk
            nodePackages.prettier
            nodePackages.vscode-langservers-extracted
            nodePackages.typescript-language-server
          ]
          ++ sharedPackages;
      };
    });
}
