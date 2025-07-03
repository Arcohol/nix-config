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
        swaybg
        swaylock
        nautilus
      ];
    };

  flake.modules.homeManager.desktop = {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          icon-theme = "Papirus-Dark";
        };
      };
    };
  };
}
