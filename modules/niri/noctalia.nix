{
  flake.modules.homeManager.niri = {
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      settings.theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
      settings.widget = {
        tray.enabled = false;
        wallpaper.enabled = false;
        control-center.enabled = false;
        session.enabled = false;
        network.show_label = false;
      };
      settings.wallpaper = {
        enabled = true;
        default.path = "${./wallpaper.jpg}";
      };
      settings.bar.default = {
        thickness = 32;
        margin_ends = 0;
        margin_edge = 0;
        radius = 0;
        background_opacity = 0.85;
      };
    };
  };
}
