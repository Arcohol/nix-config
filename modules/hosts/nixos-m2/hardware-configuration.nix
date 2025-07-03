{
  flake.modules.nixos."hosts/nixos-m2" =
    { lib, modulesPath, ... }:
    {
      imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "usbhid"
        "usb_storage"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "none";
        fsType = "tmpfs";
        options = [
          "defaults"
          "size=2G"
          "mode=755"
        ];
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/3311-1A1A";
        fsType = "vfat";
        options = [ "umask=0077" ];
      };

      fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/9d2a99dc-dae0-4add-be40-d9963074cb2f";
        fsType = "ext4";
      };

      fileSystems."/persist" = {
        device = "/dev/disk/by-uuid/357e3364-fdac-4236-887a-2097085f3f9a";
        fsType = "ext4";
        neededForBoot = true;
      };

      swapDevices = [
        {
          device = "/nix/swapfile";
          size = 16 * 1024; # 16 GiB
        }
      ];

      networking.useDHCP = lib.mkDefault true;
      nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
    };
}
