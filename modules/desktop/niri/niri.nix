{ inputs, ... }:
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      imports = [ inputs.niri.nixosModules.niri ];
      environment.variables.NIXOS_OZONE_WL = "1";
      services.displayManager.gdm.enable = true;
      services.gvfs.enable = true;
      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
      programs.xwayland = {
        enable = true;
        package = pkgs.xwayland-satellite-unstable;
      };
      environment.systemPackages = with pkgs; [
        adwaita-icon-theme
        nautilus
        pwvucontrol
      ];
    };

  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      programs.fuzzel = {
        enable = true;
        settings = {
          main = {
            icon-theme = "Papirus-Dark";
          };
        };
      };
      programs.waybar = {
        enable = true;
        systemd.enable = true;
        package = pkgs.waybar.overrideAttrs (prev: {
          patches = prev.patches or [ ] ++ [ ./fix-ignored-players.patch ];
        });
      };
    };
}
