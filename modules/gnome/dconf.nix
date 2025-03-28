{ lib, ... }:

{
  dconf = {
    enable = true;
    settings = with lib.hm.gvariant; {
      "org/gnome/desktop/background" = {
        picture-uri = "${./wallpaper.jpg}";
        picture-uri-dark = "${./wallpaper.jpg}";
        primary-color = "#241f31";
      };

      "org/gnome/desktop/screensaver" = {
        picture-uri = "${./wallpaper.jpg}";
        primary-color = "#241f31";
      };

      "org/gnome/desktop/peripherals/mouse" = {
        speed = 0.2;
        accel-profile = "flat";
      };

      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-temperature = mkUint32 3200;
      };

      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-type = "nothing";
        power-button-action = "interactive";
      };

      "org/gnome/desktop/input-sources" = {
        per-window = true;
        sources = [
          (mkTuple [
            "xkb"
            "us"
          ])
          (mkTuple [
            "ibus"
            "rime"
          ])
        ];
      };

      "org/gnome/desktop/interface" = {
        font-name = "Inter 11";
        document-font-name = "Inter 11";
        monospace-font-name = "Sarasa Mono SC 10";
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
        icon-theme = "Papirus-Dark";
      };

      "org/gnome/desktop/search-providers" = {
        disable-external = true;
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,maximize,close";
      };

      "org/gnome/mutter" = {
        dynamic-workspaces = true;
      };

      "org/gnome/shell" = {
        enabled-extensions = [
          "system-monitor@gnome-shell-extensions.gcampax.github.com"
          "paperwm@paperwm.github.com"
          "dash-to-dock@micxgx.gmail.com"
        ];
        favorite-apps = [
          "kitty.desktop"
          "firefox.desktop"
          "spotify.desktop"
          "org.telegram.desktop.desktop"
          "org.gnome.Nautilus.desktop"
        ];
      };

      "org/gnome/shell/extensions/paperwm" = {
        disable-scratch-in-overview = true;
        only-scratch-in-overview = false;
        show-window-position-bar = false;
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        show-dock-urgent-notify = false;
        intellihide-mode = "ALL_WINDOWS";
        custom-theme-shrink = true;
        apply-custom-theme = false;
        background-opacity = 0.8;
        transparency-mode = "FIXED";
      };

      "org/gnome/shell/app-switcher" = {
        current-workspace-only = true;
      };

      "org/gnome/desktop/wm/keybindings" = {
        switch-group = [ "<Alt>grave" ];
        switch-applications = [
          "<Super>Tab"
          "<Alt>Tab"
        ];
        switch-applications-backward = [
          "<Shift><Super>Tab"
          "<Shift><Alt>Tab"
        ];
      };

      "org/gnome/shell/extensions/paperwm/keybindings" = {
        close-window = [
          "<Super>BackSpace"
          "<Super>w"
        ];
        live-alt-tab = [ "" ];
        live-alt-tab-backward = [ "" ];
      };
    };
  };
}
