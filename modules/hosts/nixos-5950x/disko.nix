{
  flake.modules.nixos."hosts/nixos-5950x" =
    let
      disk0 = "/dev/disk/by-id/nvme-WDC_PC_SN730_SDBPNTY-512G-1101_2027E4454310";
      disk1 = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_500GB_S5H7NS0N884601M";
    in
    {
      services.udev.extraRules = ''
        SUBSYSTEM=="block", ENV{ID_SERIAL_SHORT}=="S5H7NS0N884601M", ENV{UDISKS_IGNORE}="1"
      '';

      disko.devices = {
        nodev."/" = {
          fsType = "tmpfs";
          mountOptions = [
            "defaults"
            "size=16G"
            "mode=755"
          ];
        };

        disk.main = {
          type = "disk";
          device = disk0;
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "1G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };
              swap = {
                size = "16G";
                content.type = "swap";
              };
              root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  extraArgs = [
                    disk1
                    "-f"
                  ];
                  subvolumes =
                    let
                      mountOptions = [ "compress=zstd" ];
                    in
                    {
                      "@nix" = {
                        mountpoint = "/nix";
                        inherit mountOptions;
                      };
                      "@persist" = {
                        mountpoint = "/persist";
                        inherit mountOptions;
                      };
                    };
                };
              };
            };
          };
        };
      };

      fileSystems."/persist".neededForBoot = true;
    };
}
