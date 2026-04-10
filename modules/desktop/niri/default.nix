{
  flake.modules.nixos.desktop =
    { inputs, pkgs, ... }:
    {
      environment.variables.NIXOS_OZONE_WL = "1";

      environment.systemPackages = with pkgs; [
        xwayland-satellite
        brightnessctl
        swaybg
        nautilus
        pwvucontrol
      ];

      programs.niri = {
        enable = true;
        package = inputs.niri-blur.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };

      programs.nautilus-open-any-terminal = {
        enable = true;
        terminal = "foot";
      };

      services.gvfs.enable = true;

      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet";
          };
        };
        useTextGreeter = true;
      };

      xdg.terminal-exec = {
        enable = true;
        settings = {
          niri = [ "foot.desktop" ];
        };
      };
    };

  flake.modules.homeManager.desktop = {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    xdg.configFile."niri/config.kdl".source = ./config.kdl;
    home.file."Pictures/wallpaper.jpg".source = ./wallpaper.jpg;

    programs.swaylock.enable = true;
  };
}
