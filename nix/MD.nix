{helpers, ...}: let
  entries = [
    {
      name = "Resumos";
      target = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/EiE_j2HugTNCsoN5Cm7GU_8Bith50SUngwhnHvoXj9p4lg?e=duyLeX";
    }
    {
      name = "Lógica de Primeira Ordem";
      children = [
        {
          name = "Aula 01 - Lógica proposicional";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/EZsLCrfk7ApNgKTBcCRnVPgBjQRm48_MmF0A7p_cykWONQ?e=tr2wQQ";
        }
        {
          name = "Aula 02 - Método de Resolução";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/ER45qocNdllNoY8BO6zlYc8ByfSBEUHuQq3xH7KappdUjQ?e=vO7hWW";
        }
        {
          name = "Aula 03 - Lógica de primeira ordem";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/EQdkDRX6X71Fi6nhyEPipwIB0GR5re4pMWACT1sgjyzNug?e=IKUI2S";
        }
        {
          name = "Aula 04 - Interpretação de Fórmulas";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/EWPQVORU3odEmlG6M4pjfLABKxSAdrUTR2KxAxucb4ow7g?e=2OHQTO";
        }
        {
          name = "Aula 04.5 - Formas Normais";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/EQZuQfuevhZNp3cKoQukoOEB1s32EVIfYnd7CIVyXeqxng?e=UwASYv";
        }
        {
          name = "Aula 05 - Unficação";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/EZHAWpZfISFBiGFmVOYLim8BZbOvkRiNMsnZEC3aR1vvGg?e=BDtZbm";
        }
        {
          name = "Aula 06 - Método de Resolução (primeira ordem)";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/EQBhgOy1t1pDu5RPWOQZzBUBwjtW_GyNoBGr692apnIY_g?e=UxtegQ";
        }
      ];
    }
    {
      name = "Enumeração Combinatória";
      children = [
        {
          name = "Aula 07 - Princípio da Gaiola dos Pombos";
          target = "https://uapt33090-my.sharepoint.com/:b:/g/personal/jcapucho_ua_pt/EfLY97KZ8klArW5u48OFY2kB9-yvjzt_DAz3g1Sq3XhiXg?e=BwMuLX";
        }
      ];
    }
  ];

  mapper = args:
    helpers.convertTyped (args
      // {
        defaultType = "external";
      });

  build = helpers.transformRecursive entries mapper;
in
  build.map
