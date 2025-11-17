{
  flake.modules.homeManager.development = {
    programs.helix = {
      enable = true;
      settings = {
        theme = "catppuccin_mocha";
        editor = {
          auto-save = {
            after-delay.enable = true;
            after-delay.timeout = 1000;
          };
        };
      };
    };
  };
}
