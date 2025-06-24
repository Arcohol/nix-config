{ pkgs, ... }:

{
  imports = [ ./fcitx5.nix ];

  environment.variables.NIXOS_OZONE_WL = "1";
  services.displayManager.gdm.enable = true;

  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [
    wl-clipboard
    xwayland-satellite-unstable
    swaybg
    swaylock
  ];
}
