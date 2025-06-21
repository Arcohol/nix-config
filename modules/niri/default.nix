{ inputs, pkgs, ... }:

let
  niri = inputs.niri;
in
{
  nixpkgs.overlays = [ niri.overlays.niri ];
  imports = [
    niri.nixosModules.niri
    ./fcitx5.nix
  ];

  environment.variables.NIXOS_OZONE_WL = "1";
  services.displayManager.gdm.enable = true;

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;
  environment.systemPackages = with pkgs; [
    fuzzel
    wl-clipboard
    wayland-utils
    libsecret
    cage
    gamescope
    xwayland-satellite-unstable
    swaybg
    swaylock
  ];
  security.pam.services.swaylock = { };
}
