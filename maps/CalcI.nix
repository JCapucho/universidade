{...}: let
  entries = [
    {
      name = "Slides teóricos";
      type = "external";
      src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/EmU2Ly7wH1hGsuRRnlU3NBIB8Ef7bKzn-2bhL6a_T9Ot5w?e=0vwDaG";
    }
    {
      name = "Testes";
      type = "external";
      src = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/ElWinTaRCX5Lvj-NCgFmgDwBPK06tNkMKM87UDhI313cQw?e=JExRUC";
    }
  ];
in {
  name = "Cálculo I";
  shorthand = "C-I";
  map = entries;
}
