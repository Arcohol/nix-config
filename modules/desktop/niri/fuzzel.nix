{
  flake.modules.homeManager.niri = {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          icon-theme = "Papirus-Dark";
          terminal = "foot";
          filter-desktop = true;
        };
      };
    };
  };
}
