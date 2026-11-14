{
  flake.modules.nixos.niri = { pkgs, ... }: {
    environment.variables.NIXOS_OZONE_WL = "1";

    environment.systemPackages = with pkgs; [
      xwayland-satellite
      brightnessctl
      nautilus
      pwvucontrol
    ];

    programs.niri.enable = true;
    services.displayManager.gdm.enable = true;

    programs.nautilus-open-any-terminal = {
      enable = true;
      terminal = "foot";
    };

    services.gvfs.enable = true;

    xdg.terminal-exec = {
      enable = true;
      settings = {
        niri = [ "foot.desktop" ];
      };
    };
  };

  flake.modules.homeManager.niri = { lib, pkgs, ... }: {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        font-name = "sans-serif 12";
      };
    };

    xdg.configFile."niri/config.kdl".source = ./config.kdl;
    xdg.configFile."niri/lock" = {
      executable = true;
      text = lib.mkDefault ''
        #!${pkgs.runtimeShell}
        swaylock -f -i ${./wallpaper.jpg} && sleep 2 && niri msg action power-off-monitors
      '';
    };

    programs.swaylock.enable = true;
  };
}
