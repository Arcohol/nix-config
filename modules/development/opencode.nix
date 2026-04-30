{
  flake.modules.homeManager.development = {
    programs.opencode = {
      enable = true;
      web.enable = true;
    };
    home.persist = [
      ".local/share/opencode"
      ".local/state/opencode"
    ];
  };
}
