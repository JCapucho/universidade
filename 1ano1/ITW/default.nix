{
  helpers,
  python3,
  ...
}: let
  entries = [
    {
      name = "Aula 01";
      type = "site";
      src = ./wwwroot/Aula01;
    }
    {
      name = "Aula 02";
      type = "site";
      src = ./wwwroot/Aula02;
    }
    {
      name = "Aula 03";
      type = "site";
      src = ./wwwroot/Aula03;
      config.this.has_index = false;
      children = [
        {
          name = "Exercício 1";
          type = "link";
          src = "aula03e01.html";
        }
        {
          name = "Exercício 2";
          type = "link";
          src = "aula03e02.html";
        }
        {
          name = "Exercício 3";
          type = "link";
          src = "aula03e03.html";
        }
        {
          name = "Exercício 4";
          type = "link";
          src = "aula03e04.html";
        }
        {
          name = "Exercício 5";
          type = "link";
          src = "aula03e05.html";
        }
      ];
    }
    {
      name = "Aula 04";
      type = "site";
      src = ./wwwroot/Aula04;
    }
    {
      name = "Aula 05";
      type = "site";
      src = ./wwwroot/Aula05;
    }
    {
      name = "Aula 06";
      type = "site";
      src = ./wwwroot/Aula06;
      config.this.has_index = false;
      children = [
        {
          name = "Calculadora";
          type = "link";
          src = "index.html";
        }
        {
          name = "Lâmpada";
          type = "link";
          src = "lamp.html";
        }
        {
          name = "Jogo";
          type = "link";
          src = "jogo.html";
        }
      ];
    }
    {
      name = "Aula 07";
      type = "site";
      src = ./wwwroot/Aula07;
      config.this.has_index = false;
      children = [
        {
          name = "Calculadora";
          type = "link";
          src = "ex1.html";
        }
        {
          name = "Formulário";
          type = "link";
          src = "ex2.html";
        }
        {
          name = "TODO";
          type = "link";
          src = "ex3.html";
        }
        {
          name = "Totobola";
          type = "link";
          src = "ex4.html";
        }
      ];
    }
    {
      name = "Aula 09";
      type = "site";
      src = ./wwwroot/Aula09;
      config.this.has_index = false;
      children = [
        {
          name = "Exercício 1";
          type = "link";
          src = "ex1-temperaturas.html";
        }
        {
          name = "Exercício 2";
          type = "link";
          src = "ex2-concerto.html";
        }
        {
          name = "Exercício 3";
          type = "link";
          src = "ex3-concerto.html";
        }
      ];
    }
    {
      name = "Aula 10";
      type = "site";
      src = ./wwwroot/Aula10;
      config.this.has_index = false;
      children = [
        {
          name = "Meteorologia";
          type = "link";
          src = "index.html";
        }
        {
          name = "Conferência";
          type = "link";
          src = "conference.html";
        }
      ];
    }
    {
      name = "Teste prático";
      type = "site";
      src = ./wwwroot/teste-pratico;
      config.this.root = "teste7.html";
    }
    {
      name = "Projeto final";
      type = "external";
      src = "https://github.com/JCapucho/itw-projeto-final";
    }
    {
      name = "Slides Teóricos";
      type = "external";
      src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/EpThdIHwCi5FnB6SlDNixQAB5_972mgM4e5S2vVKfRNPIw?e=m5Nk9L";
    }
    {
      name = "Guiões Práticos";
      type = "external";
      src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/EkNJtYsFY8BNpMldj2Dxl_UBbwtdTq_OKDvpPql9c6Emxw?e=IHyDw0";
    }
  ];

  python = python3.withPackages (pyPkgs:
    with pyPkgs; [
      jinja2
      pygments
      beautifulsoup4
      lxml
    ]);

  convertSite = {
    src,
    name,
    prefix,
    config,
  }:
    helpers.generateBase ({
        inherit src name prefix config;

        buildPhase = let
          out = "$out/${prefix}";
        in ''
          mkdir -p "${out}/raw"
          cp -a "${src}/." "${out}/"

          chmod -R +w "${out}"

          ${python}/bin/python3 ${./build.py} \
            --template-dir ${helpers.templates} \
            "${out}" "${name}" "${src}"
        '';
      }
      // (
        if config.has_index or true
        then {props.href = "${prefix}/${config.root or "index.html"}";}
        else {}
      ));

  convertLink = {
    src,
    name,
    prefix,
    config,
  }:
    helpers.generateBase {
      inherit src name prefix config;
      props.href = "${builtins.dirOf prefix}/${src}";
    };
in {
  name = "Introdução as tecnologias web";
  shorthand = "ITW";
  map = entries;
  config = {
    this = {
      pre = src: out: ''cp -r "${./wwwroot/lib}" "${out}/lib"'';
    };
    extraTypes = {
      site = convertSite;
      link = convertLink;
    };
  };
}
