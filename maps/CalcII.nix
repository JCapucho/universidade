{...}: let
  entries = [
    {
      name = "Folhas de exercícios";
      type = "external";
      src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/EgrBnOgiXlNAqERHrVf6oWwBi7G949jFypCWdy25dOR71g?e=ODmfgg";
    }
    {
      name = "Resumos";
      type = "external";
      src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/EuKxklW_PxBIsFel7DpAABMBvRu3bCIFsd0noAL2TWOT7g?e=4xeVbi";
    }
    {
      name = "Slides teóricos";
      type = "external";
      src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/Em3p3Jabi0xOtsjaapFsfnwBJoynMwRBc4AnMoahgT5i1g?e=BqpVbC";
    }
    {
      name = "Testes";
      type = "external";
      src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/Ei70rAeD-YVCm49LDXt5wy0B_O-3GiGy_1a1W26AVBvy8g?e=gnYoVx";
    }
  ];
in {
  name = "Cálculo II";
  shorthand = "C-II";
  map = entries;
}