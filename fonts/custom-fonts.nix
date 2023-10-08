{pkgs, ...}: let
  metric-override = {
    cap = 790;
    ascender = 790;
    xHeight = 570;
  };

  # Based on Xe's iosevka aile iaso
  # https://github.com/Xe/iosevka
  iosevka-aile = pkgs.iosevka.override {
    set = "aile";
    privateBuildPlan = {
      family = "Iosevka Aile Resumos";
      spacing = "quasi-proportional";
      no-ligation = true;
      no-cv-ss = true;
      variants = {
        inherits = "ss01";
        design = {
          tilde = "low";
          number-sign = "slanted-tall";
          at = "fourfold-solid-inner-tall";
        };
      };
      slopes = {
        upright = {
          angle = 0;
          shape = "upright";
          menu = "upright";
          css = "normal";
        };
        italic = {
          angle = 9.4;
          shape = "italic";
          menu = "italic";
          css = "italic";
        };
      };
      weights.regular = {
        shape = 400;
        menu = 400;
        css = 400;
      };
      weights.bold = {
        shape = 900;
        menu = 900;
        css = 900;
      };
      inherit metric-override;
    };
  };

  # Based on Xe's iosevka curly iaso (carbon copy :p)
  # https://github.com/Xe/iosevka
  iosevka-curly = pkgs.iosevka.override {
    set = "curly";
    privateBuildPlan = {
      family = "Iosevka Curly Resumos";
      spacing = "term";
      serifs = "sans";
      no-ligation = false;
      ligations = {"inherit" = "default-calt";};
      no-cv-ss = true;
      variants = {
        inherits = "ss01";
        design = {
          tilde = "low";
          number-sign = "slanted-tall";
          at = "fourfold-solid-inner-tall";
        };
      };
      slopes.upright = {
        angle = 0;
        shape = "upright";
        menu = "upright";
        css = "normal";
      };
      weights.regular = {
        shape = 400;
        menu = 400;
        css = 400;
      };
      widths.normal = {
        shape = 500;
        menu = 7;
        css = "normal";
      };
      inherit metric-override;
    };
  };
in
  pkgs.stdenvNoCC.mkDerivation {
    name = "iosevka-resumos";
    dontUnpack = true;
    buildInputs = with pkgs; [python311Packages.brotli python311Packages.fonttools];
    buildPhase = ''
      mkdir -p ttf
      for ttf in ${iosevka-curly}/share/fonts/truetype/*.ttf ${iosevka-aile}/share/fonts/truetype/*.ttf; do
        cp $ttf .

        echo "processing $ttf"

        name=`basename -s .ttf $ttf`
        pyftsubset \
          $ttf \
          --output-file="$name".woff2 \
          --flavor=woff2 \
          --layout-features=* \
          --no-hinting \
          --desubroutinize \
          --unicodes="U+0000-0170,U+00D7,U+00F7,U+2000-206F,U+2074,U+20AC,U+2122,U+2190-21BB,U+2212,U+2215,U+F8FF,U+FEFF,U+FFFD,U+00E8"
        mv *.ttf ttf
      done
    '';
    installPhase = ''
      mkdir -p $out
      cp *.woff2 $out
    '';
  }
