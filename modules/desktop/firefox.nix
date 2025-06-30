{
  flake.modules.homeManager.desktop = {
    programs.firefox.enable = true;
    home.persist = [ ".mozilla" ];
  };
}
