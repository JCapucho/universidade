{
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
    in {
      # packages.default = pkgs.mkDerivation {
      #   pname = "export";
      #   version = "0.1";
      #
      #   buildInputs = [
      #     pandoc
      #     neorg-pandoc
      #   ];
      #
      #   buildPhase = ''
      #     mkdir -p $out
      #     ./build.sh
      #   '';
      #
      #   src = ./.;
      # };
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          black
          ghostscript
          imagemagick
          python3Packages.python-lsp-server
          python3Packages.matplotlib
          pandoc
          neorg-pandoc
          dotnet-sdk
          nodePackages.prettier
          jdk
        ];
      };
    });
}
