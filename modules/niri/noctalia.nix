{
  flake.modules.homeManager.niri = {
    home.persist.directories = [ ".local/state/noctalia" ];

    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      settings.plugins.enabled = [ "noctalia/world_clock" ];
      settings.idle.behavior = {
        lock = {
          timeout = 600;
          action = "lock";
        };
        screen-off = {
          timeout = 660;
          action = "screen_off";
        };
      };
      settings.osd.kinds.keyboard_layout = false;
      settings.shell.mpris.blacklist = [
        "firefox"
        "chrome"
        "mpv"
      ];
      settings.theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
      settings.widget = {
        media = {
          actions = {
            left = "media toggle";
            right = "media next";
            middle = "media previous";
            scroll_up = "media volume-up";
            scroll_down = "media volume-down";
          };
          hide_when_no_media = true;
        };
        tray.enabled = false;
        wallpaper.enabled = false;
        control-center.enabled = false;
        network.show_label = false;
        clock.actions.left = "panel-toggle noctalia/world_clock:panel";
      };
      settings.wallpaper = {
        enabled = true;
        default.path = "${./wallpaper.jpg}";
      };
      settings.bar.default = {
        start = [
          "session"
          "notifications"
          "clipboard"
          "keyboard_layout"
          "workspaces"
        ];
        center = [ "clock" ];
        end = [
          "media"
          "network"
          "bluetooth"
          "volume"
          "brightness"
          "battery"
          "date"
        ];
        thickness = 28;
        margin_ends = 0;
        margin_edge = 0;
        radius = 0;
        background_opacity = 0.85;
      };
    };
  };
}
