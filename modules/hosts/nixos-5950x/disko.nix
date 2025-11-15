{
  flake.modules.nixos."hosts/nixos-5950x" =
    let
      disk0 = "/dev/disk/by-id/nvme-WDC_PC_SN730_SDBPNTY-512G-1101_2027E4454310";
      disk1 = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_500GB_S5H7NS0N884601M";
    in
    {
      disko.devices = {
        nodev."/" = {
          fsType = "tmpfs";
          mountOptions = [
            "defaults"
            "size=16G"
            "mode=755"
          ];
        };

        disk.primary = {
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
                  subvolumes = {
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd" ];
                    };
                    "@persist" = {
                      mountpoint = "/persist";
                      mountOptions = [ "compress=zstd" ];
                    };
                  };
                };
              };
            };
          };
        };

        disk.secondary = {
          type = "disk";
          device = disk1;
          content = {
            type = "gpt";
            partitions = {
              root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  subvolumes = {
                    "@storage" = {
                      mountpoint = "/storage";
                      mountOptions = [ "compress=zstd" ];
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
