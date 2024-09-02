{ lib, ... }:

{
  dconf = {
    enable = true;
    settings = with lib.hm.gvariant; {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";

      "org/gnome/desktop/background" = {
        picture-uri = "${./wallpaper.jpg}";
        picture-uri-dark = "${./wallpaper.jpg}";
        primary-color = "#241f31";
      };

      "org/gnome/desktop/screensaver" = {
        picture-uri = "${./wallpaper.jpg}";
        primary-color = "#241f31";
      };

      "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,maximize,close";

      "org/gnome/desktop/interface" = {
        font-name = "Inter 11";
        document-font-name = "Inter 11";
        monospace-font-name = "Hack 10";
      };

      "org/gnome/desktop/peripherals/mouse" = {
        speed = 0.2;
        accel-profile = "flat";
      };

      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-temperature = mkUint32 3200;
      };
    };
  };
}
