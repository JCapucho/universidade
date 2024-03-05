{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      devShell = let
        string-template = pkgs.stdenv.mkDerivation rec {
          pname = "StringTemplate";
          version = "4.3.4";
          src = pkgs.fetchurl {
            url = "https://www.stringtemplate.org/download/ST-${version}.jar";
            sha256 = "sha256-+SesOExG10n4texolypTrtIeADE1CSmWFu23O/oV/zM=";
          };
          phases = ["installPhase"];
          installPhase = ''
            set -eu
            mkdir -p $out/share/java
            cp ${src} $out/share/java/ST-${version}.jar
          '';
        };

        jdk-docs = pkgs.stdenv.mkDerivation rec {
          pname = "jdk_doc-all";
          version = "17.0.10";
          src = pkgs.fetchzip {
            url = "https://download.oracle.com/otn_software/java/jdk/${version}+11/a473b47039a34b169d45b00685dea3dd/jdk-${version}_doc-all.zip";
            sha256 = "sha256-ZO1BMUhVa6c8C9ey/Ts5MROYA3P2YOkHMjbRs6kdImA=";
          };
          installPhase = ''
            set -eu
            mkdir -p $out/share/doc
            cp -r . $out/share/doc
          '';
        };

        antlr4-path = pkgs.symlinkJoin {
          name = "antlr4-path";
          paths = [pkgs.antlr string-template];
        };

        antlr4-bin = pkgs.stdenv.mkDerivation rec {
          pname = "antlr4-bin";
          version = "6.4";
          src = ./antlr4-bin;
          buildInputs = with pkgs; [bash bc];
          nativeBuildInputs = [pkgs.makeWrapper pkgs.jdk17];
          installPhase = ''
            set -e
            mkdir -p $out/bin

            substituteInPlace view-javadoc \
              --replace "@JDK_DOCS_DIR@" "${jdk-docs}/share/doc"

            for filename in ./*; do
              OUT=$out/bin/"$(basename "$filename")"
              cp "$filename" "$OUT"
              wrapProgram "$OUT" \
                --prefix PATH : ${pkgs.lib.makeBinPath buildInputs} \
                --set ANTLR4_PATH "${antlr4-path}/share/java"
            done
          '';
        };
      in
        pkgs.mkShell {
          packages = with pkgs; [
            jdk17
            doxygen
            antlr4-bin
          ];
        };
    });
}
