{...}: let
  entries = [
    {
      name = "Cheat Sheet";
      type = "norg";
      src = ./notes/cheatsheet.norg;
    }
    {
      name = "Regressão linear";
      type = "norg";
      src = ./notes/linreg.norg;
    }
    {
      name = "Método de Euler";
      type = "norg";
      src = ./notes/euler.norg;
    }
    {
      name = "Forças";
      type = "norg";
      src = ./notes/forces.norg;
    }
    {
      name = "Energia e Trabalho";
      type = "norg";
      src = ./notes/work.norg;
    }
    {
      name = "Integração numérica";
      type = "norg";
      src = ./notes/int.norg;
    }
    {
      name = "Momento e colisões";
      type = "norg";
      src = ./notes/collisions.norg;
    }
    {
      name = "Slides teóricos";
      type = "external";
      src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/EiBQ_4gRz79Mq-MdPpM4stwBCvhJ7tiaxazbuxOObDiK1A?e=ycMBJ5";
    }
    {
      name = "Guiões";
      children = [
        {
          name = "Guiões";
          type = "external";
          src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/Etzx87VMIY5Hgc_nZyznkp4Bsr6TBWCkq2nJxRv2VW_sQg?e=e23jka";
        }
        {
          name = "Prática 2";
          type = "notebook";
          src = ./aula02/guiao.ipynb;
        }
        {
          name = "Prática 3";
          type = "notebook";
          src = ./aula03/guiao.ipynb;
        }
        {
          name = "Prática 4";
          type = "notebook";
          src = ./aula04/guiao.ipynb;
        }
        {
          name = "Prática 5";
          type = "notebook";
          src = ./aula05/guiao.ipynb;
        }
        {
          name = "Prática 6";
          type = "notebook";
          src = ./aula06/guiao.ipynb;
        }
        {
          name = "Prática 7";
          type = "notebook";
          src = ./aula07/guiao.ipynb;
        }
        {
          name = "Prática 8";
          type = "notebook";
          src = ./aula08/guiao.ipynb;
        }
        {
          name = "Prática 9";
          type = "notebook";
          src = ./aula09/guiao.ipynb;
        }
        {
          name = "Prática 10";
          type = "notebook";
          src = ./aula10/guiao.ipynb;
        }
        {
          name = "Prática 11";
          type = "notebook";
          src = ./aula11/guiao.ipynb;
        }
        {
          name = "Prática 12";
          type = "notebook";
          src = ./aula12/guiao.ipynb;
        }
        {
          name = "Prática 13";
          type = "notebook";
          src = ./aula13/guiao.ipynb;
        }
      ];
    }
    {
      name = "Testes computacionais";
      children = [
        {
          name = "Teste 1 (2022-2023)";
          type = "notebook";
          src = ./teste/resolucao.ipynb;
        }
        {
          name = "Teste 2 (2022-2023)";
          type = "notebook";
          src = ./teste2/resolucao.ipynb;
        }
        {
          name = "Teste 3 (2021-2022)";
          type = "notebook";
          src = ./teste3-2021/resolucao.ipynb;
        }
        {
          name = "Teste 3 (2022-2023)";
          type = "notebook";
          src = ./teste3/resolucao.ipynb;
        }
      ];
    }
  ];
in {
  name = "Modelação de Sistemas Físicos";
  shorthand = "MSF";
  map = entries;
  config = {
    pre = src: out: ''
      export MPLCONFIGDIR=/build/.config/matplotlib
    '';
    this = {
      pre = src: out: ''cp -r "${./notes/assets}" "${out}/assets"'';
      nestDocuments = false;
    };
  };
}
