{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 = {
          addons = with pkgs; [
            fcitx5-gtk
            (fcitx5-rime.override { rimeDataPkgs = [ rime-ice ]; })
            fcitx5-fluent
          ];
          waylandFrontend = true;
          # ignoreUserConfig = true;
          settings = {
            addons = {
              classicui.globalSection.Theme = "FluentDark-solid";
            };
            inputMethod = {
              "Groups/0" = {
                Name = "Default";
                "Default Layout" = "us";
                DefaultIM = "keyboard-us";
              };
              "Groups/0/Items/0".Name = "keyboard-us";
              "Groups/0/Items/1".Name = "rime";
            };
          };
        };
      };
    };

  flake.modules.homeManager.desktop = {
    home.persist = [ ".local/share/fcitx5" ];
  };
}
