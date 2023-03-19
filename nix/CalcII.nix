{helpers, ...}: let
  entries = [
    {
      name = "Resumos";
      target = "https://uapt33090-my.sharepoint.com/:f:/g/personal/jcapucho_ua_pt/EuyAFPpIiv1NtM3Q5r9g0AoB_4ntyJuT9thYvp5oL0sNtg?e=mM8dtF";
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
