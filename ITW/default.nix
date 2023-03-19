{
  mkDerivation,
  helpers,
  python3,
  ...
}: let
  entries = [
    {
      name = "Aula 01";
      target = "wwwroot/Aula01";
    }
    {
      name = "Aula 02";
      target = "wwwroot/Aula02";
    }
    {
      name = "Aula 03";
      target = "wwwroot/Aula03";
      has_index = false;
      children = [
        {
          name = "Exercício 1";
          type = "link";
          target = "aula03e01.html";
        }
        {
          name = "Exercício 2";
          type = "link";
          target = "aula03e02.html";
        }
        {
          name = "Exercício 3";
          type = "link";
          target = "aula03e03.html";
        }
        {
          name = "Exercício 4";
          type = "link";
          target = "aula03e04.html";
        }
        {
          name = "Exercício 5";
          type = "link";
          target = "aula03e05.html";
        }
      ];
    }
    {
      name = "Aula 04";
      target = "wwwroot/Aula04";
    }
    {
      name = "Aula 05";
      target = "wwwroot/Aula05";
    }
    {
      name = "Aula 06";
      target = "wwwroot/Aula06";
      has_index = false;
      children = [
        {
          name = "Calculadora";
          type = "link";
          target = "index.html";
        }
        {
          name = "Lâmpada";
          type = "link";
          target = "lamp.html";
        }
        {
          name = "Jogo";
          type = "link";
          target = "jogo.html";
        }
      ];
    }
    {
      name = "Aula 07";
      target = "wwwroot/Aula07";
      has_index = false;
      children = [
        {
          name = "Calculadora";
          type = "link";
          target = "ex1.html";
        }
        {
          name = "Formulário";
          type = "link";
          target = "ex2.html";
        }
        {
          name = "TODO";
          type = "link";
          target = "ex3.html";
        }
        {
          name = "Totobola";
          type = "link";
          target = "ex4.html";
        }
      ];
    }
    {
      name = "Aula 09";
      target = "wwwroot/Aula09";
      has_index = false;
      children = [
        {
          name = "Exercício 1";
          type = "link";
          target = "ex1-temperaturas.html";
        }
        {
          name = "Exercício 2";
          type = "link";
          target = "ex2-concerto.html";
        }
        {
          name = "Exercício 3";
          type = "link";
          target = "ex3-concerto.html";
        }
      ];
    }
    {
      name = "Aula 10";
      target = "wwwroot/Aula10";
      has_index = false;
      children = [
        {
          name = "Meteorologia";
          type = "link";
          target = "index.html";
        }
        {
          name = "Conferência";
          type = "link";
          target = "conference.html";
        }
      ];
    }
    {
      name = "Teste prático";
      target = "wwwroot/teste-prático";
      root = "teste7.html";
    }
    {
      name = "Projeto final";
      type = "external";
      target = "https://github.com/JCapucho/itw-projeto-final";
    }
  ];

  python = python3.withPackages (pyPkgs:
    with pyPkgs; [
      jinja2
      pygments
      beautifulsoup4
    ]);

  mapper = {
    out,
    node,
    ...
  } @ ctx: let
    type = node.type or "site";
  in
    if type == "external"
    then helpers.convertExternal ctx
    else if type == "site"
    then
      {
        buildCommands = ''
          mkdir -p $out/'${out}'/raw
          cp -r $src/'${node.target}'/. $out/'${out}'

          chmod -R +w $out/'${out}'

          ${python}/bin/python3 ${./build.py} \
            --template-dir ${helpers.templates} \
            $out/'${out}' '${node.name}' $src/'${node.target}'
        '';
      }
      // (
        if node.has_index or true
        then {meta.href = "${out}/${node.root or "index.html"}";}
        else {}
      )
    else if type == "link"
    then {
      meta.href = "${builtins.dirOf out}/${node.target}";
    }
    else builtins.throw "Unknown node type ${type}";

  build = helpers.transformRecursive entries mapper;
in
  mkDerivation {
    pname = "ITW";
    version = "0.1";

    dontInstall = true;

    buildPhase = ''
      runHook preBuild

      mkdir -p $out
      cp -r $src/wwwroot/lib $out/lib
      ${build.buildCommands}

      runHook postBuild
    '';

    passthru.map = build.map;

    src = ./.;
  }
