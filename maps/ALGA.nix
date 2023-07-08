{...}: let
  entries = [
    {
      name = "Folhas de exercícios";
      type = "external";
      src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/Ek8ApOEPLJNBsAwPjEHfqYsB-KBmMg0z-UCoeG2y8nlZOQ?e=4wCei0";
    }
    {
      name = "Slides teóricos";
      type = "external";
      src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/EtsY0LR81D1JuG5Dbq5kjbcB-t3ky9d6WomIZ-ICWN_M6w?e=YTzI6B";
    }
    {
      name = "Testes";
      type = "external";
      src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/EuqypuPh3BlNjYpRQRhUW4cBJXkA4KlE_AbIRY_P2qd0YA?e=ENqawy";
    }
  ];
in {
  name = "Álgebra Linear e Geometria Analítica";
  shorthand = "ALGA";
  map = entries;
}
