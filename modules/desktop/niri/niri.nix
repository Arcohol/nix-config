{ inputs, ... }:
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [ inputs.niri.overlays.niri ];
      imports = [ inputs.niri.nixosModules.niri ];

      environment.variables.NIXOS_OZONE_WL = "1";
      services.displayManager.gdm.enable = true;
      services.gvfs.enable = true;

      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };

      environment.systemPackages = with pkgs; [
        xwayland-satellite-unstable
        adwaita-icon-theme
        nautilus
        pwvucontrol
      ];
    };
}
