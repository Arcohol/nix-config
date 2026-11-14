{
  flake.modules.homeManager.niri = {
    home.persist.directories = [ ".local/state/noctalia" ];

    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      settings.osd.kinds.keyboard_layout = false;
      settings.theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
      settings.widget = {
        tray.enabled = false;
        wallpaper.enabled = false;
        control-center.enabled = false;
        network.show_label = false;
      };
      settings.wallpaper = {
        enabled = true;
        default.path = "${./wallpaper.jpg}";
      };
      settings.bar.default = {
        end = [
          "media"
          "notifications"
          "clipboard"
          "keyboard_layout"
          "network"
          "bluetooth"
          "volume"
          "brightness"
          "battery"
          "session"
        ];
        thickness = 32;
        margin_ends = 0;
        margin_edge = 0;
        radius = 0;
        background_opacity = 0.85;
      };
    };
  };
}
