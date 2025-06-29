{ pkgs, ... }:

{
  imports = [ ./fcitx5.nix ];

  environment.variables.NIXOS_OZONE_WL = "1";
  services.displayManager.gdm.enable = true;

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
  ];
}
