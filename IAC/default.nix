{...}: let
  entries = [
    {
      name = "Representação digital de informação";
      type = "norg";
      src = ./repr-digital.norg;
    }
    {
      name = "Lógica binária e Circuitos";
      type = "norg";
      src = ./binary-logic.norg;
    }
    {
      name = "Blocos combinatórios";
      type = "norg";
      src = ./combinatorios.norg;
    }
    {
      name = "Circuitos sequenciais";
      type = "norg";
      src = ./sequenciais.norg;
    }
    {
      name = "Arquitetura de computadores";
      type = "norg";
      src = ./arquitetura-de-computadores.norg;
    }
    {
      name = "Arquitetura MIPS";
      type = "norg";
      src = ./mips.norg;
    }
    {
      name = "Instruções MIPS";
      type = "norg";
      src = ./inst-mips.norg;
    }
    {
      name = "Converter código para assembly";
      type = "norg";
      src = ./writing-assembly.norg;
    }
  ];
in {
  name = "Introdução à Arquitetura de Computadores";
  shorthand = "IAC";
  map = entries;
  config = {
    this = {
      pre = src: out: ''cp -r "${./assets}" "${out}/assets"'';
      nestDocuments = false;
    };
  };
}
