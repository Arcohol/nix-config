{
  flake.modules.homeManager.niri = {
    services.mako = {
      enable = true;
      settings = {
        font = "monospace 16px";
        default-timeout = 5000;
      };
    };
  };
}
