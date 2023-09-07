{...}: let
  entries = [
    {
      name = "Código aulas";
      type = "external";
      src = "https://github.com/JCapucho/universidade/tree/f3357b13a4cd1529764d10ee5680dd37df251fc1/POO/src";
    }
    {
      name = "Testes";
      type = "external";
      src = "https://github.com/JCapucho/universidade/tree/f3357b13a4cd1529764d10ee5680dd37df251fc1/POO/testes";
    }
  ];
in {
  name = "Programação Orientada a Objetos";
  shorthand = "POO";
  map = entries;
}
