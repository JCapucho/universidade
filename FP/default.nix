{
  mkDerivation,
  helpers,
  ...
}: let
  entries = [
    {
      name = "Aula 00";
      children = [
        {
          name = "Enunciado";
          type = "external";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/Ef3QHqRi00BAkrBolrf2QkwBzFh8cg9wvmcdC8q7Xgh6kw?e=zhBZvu";
        }
        {
          name = "Resolução";
          target = "aula00/aula00.norg";
        }
      ];
    }
    {
      name = "Aula 01";
      children = [
        {
          name = "Enunciado";
          type = "external";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/EYoQDD-ZSO1MopgWyyhvELABgW9yPgdiZi-SSAYV0vmzFg?e=anZ8jt";
        }
        {
          name = "Resolução";
          target = "aula01/aula01.norg";
        }
      ];
    }
    {
      name = "Aula 02";
      type = "group";
      workdir = "aula02";
      children = [
        {
          name = "Enunciado";
          type = "external";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/ERwvWVd6HyJHj4O3LHN5J-8B4rBua91fPnL5-vBayxu17g?e=iedhcE";
        }
        {
          name = "Resolução";
          target = "aula02/aula02.norg";
        }
      ];
    }
    {
      name = "Aula 03";
      children = [
        {
          name = "Enunciado";
          type = "external";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/EcBJWOCmf6NGkYdtNfQ4aIIBLHmfAGrh1wn2C0sxzBgJFQ?e=b4m1yo";
        }
        {
          name = "Resolução";
          target = "aula03/aula03.norg";
        }
      ];
    }
    {
      name = "Aula 04";
      children = [
        {
          name = "Enunciado";
          type = "external";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/EZeg6drhFhJEqp5YoZmltksB6P12MWcBKqA22DD-z9MsCw?e=2S8O3m";
        }
        {
          name = "Resolução";
          target = "aula04/aula04.norg";
        }
      ];
    }
    {
      name = "Aula 05";
      children = [
        {
          name = "Enunciado";
          type = "external";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/EZeg6drhFhJEqp5YoZmltksB6P12MWcBKqA22DD-z9MsCw?e=2S8O3m";
        }
        {
          name = "Resolução";
          target = "aula05/aula05.norg";
        }
      ];
    }
    {
      name = "Aula 06";
      children = [
        {
          name = "Enunciado";
          type = "external";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/EWB5a0LS8GlCowfAZdz3NZMBBxkKeeBRGCdOBQqVu2dKOQ?e=JIDDvx";
        }
        {
          name = "Resolução";
          target = "aula06/aula06.norg";
        }
      ];
    }
    {
      name = "Aula 07";
      children = [
        {
          name = "Enunciado";
          type = "external";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/Eds6QOu8BM5IvJ0ofRCAZ9wBy2vFMPYHf2T2ScLuHLGfng?e=xjmjFD";
        }
        {
          name = "Resolução";
          target = "aula07/aula07.norg";
        }
      ];
    }
    {
      name = "Aula 08";
      children = [
        {
          name = "Enunciado";
          type = "external";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/EbfzvALWcYNMsY2gLvw4W9QBABa5I1pr4tHaqZN9YDM3-w?e=owfm9C";
        }
        {
          name = "Resolução";
          target = "aula08/aula08.norg";
        }
      ];
    }
    {
      name = "Aula 09";
      children = [
        {
          name = "Enunciado";
          type = "external";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/Ed7Iy0Vd2KpAjPvq3CybZSQBhBOTdU7fl6RyFW1RYSYONA?e=uMB3YZ";
        }
        {
          name = "Resolução";
          target = "aula09/aula09.norg";
        }
      ];
    }
    {
      name = "Aula 10";
      children = [
        {
          name = "Enunciado";
          type = "external";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/EVjflqp7okNJsPq052dvO10BNt0bgqbxUU9j5FXYEkQWUg?e=A3FcRt";
        }
        {
          name = "Resolução";
          target = "aula10/aula10.norg";
        }
      ];
    }
    {
      name = "APx2";
      children = [
        {
          name = "APx2 (PDF)";
          type = "external";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/EcUM50BIEN5HviKb1l3_7-0B2lnOCUSE_KLEv5qymZGo5w?e=CdA675";
        }
        {
          name = "Solution";
          type = "code";
          target = "apx2/shop.py";
        }
      ];
    }
  ];

  mapper = {
    out,
    node,
    ...
  } @ args:
    helpers.convertTyped (args
      // {
        defaultType = "norg";
        preBuildCommands = ''
          mkdir -p $out/'${out}'
        '';
        perTypeCommands = {
          norg = {
            pre = ''
              [ -d "$src/$(dirname '${node.target}')/res" ] && cp -r "$src/$(dirname '${node.target}')/res" $out/'${out}'
            '';
          };
        };
      });

  build = helpers.transformRecursive entries mapper;
in
  mkDerivation {
    pname = "FP";
    version = "0.1";

    dontInstall = true;

    buildPhase = ''
      runHook preBuild

      ${build.buildCommands}

      runHook postBuild
    '';

    passthru.map = build.map;

    src = ./.;
  }
