{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../common.nix

    ./hardware-configuration.nix
    ./persist.nix
  ];

  networking.hostName = "nixos-4800u";

  systemd.tmpfiles.rules = [ "L+ /run/gdm/.config/monitors.xml - - - - ${./monitors.xml}" ];
}
