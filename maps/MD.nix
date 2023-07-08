{...}: let
  entries = [
    {
      name = "Resumos";
      type = "external";
      src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/EiE_j2HugTNCsoN5Cm7GU_8Bith50SUngwhnHvoXj9p4lg?e=duyLeX";
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
