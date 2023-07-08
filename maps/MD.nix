{...}: let
  entries = [
    {
      name = "Folhas exercícios";
      type = "external";
      src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/Et0wsLWZYodKkF5vxtq4zpoBU75zhGU1BxSPCu2dMKh1xw?e=LGTHHZ";
    }
    {
      name = "Slides teóricos";
      type = "external";
      src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/ElkmbZ-4G9VCvCexm81OBm8BEckFT58ZCrkgiW77F-eNdA?e=DEoBJj";
    }
    {
      name = "Testes";
      type = "external";
      src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/EjlIm8Dr9kZEi47Tba9ZdO8BBFntaubCxYVEghZqCe0xCQ?e=hqdhBO";
    }
    {
      name = "Resumos Ruben";
      type = "external";
      src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/rubengarrido_ua_pt/EpjWNcOfU0xPksoKvbusRK8Bj69MPKm5mT8urtO2lpeXgQ?e=mxfHnV";
    }
  ];
in {
  name = "Matemática Discreta";
  shorthand = "MD";
  map = entries;
}
