{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../common.nix

    ./disko.nix
    ./hardware-configuration.nix
    ./persist.nix
  ];

  networking.hostName = "nixos-5950x";

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;

  systemd.tmpfiles.rules = [ "L+ /run/gdm/.config/monitors.xml - - - - ${./monitors.xml}" ];
}
