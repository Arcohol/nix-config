{
  flake.modules.homeManager.desktop = {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          icon-theme = "Papirus-Dark";
          filter-desktop = true;
        };
      };
    };
  };
}
