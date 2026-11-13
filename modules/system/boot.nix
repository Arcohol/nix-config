{
  flake.modules.nixos.boot = { lib, pkgs, ... }: {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.configurationLimit = 10;
    boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  };
}
