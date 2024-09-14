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
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  systemd.tmpfiles.rules = [ "L+ /run/gdm/.config/monitors.xml - - - - ${./monitors.xml}" ];
}
