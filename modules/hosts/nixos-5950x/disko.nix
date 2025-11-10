{
  flake.modules.nixos."hosts/nixos-5950x" = {
    disko.devices = {
      nodev."/" = {
        fsType = "tmpfs";
        mountOptions = [
          "defaults"
          "size=8G"
          "mode=755"
        ];
      };

      disk = {
        primary = {
          type = "disk";
          device = "/dev/nvme0n1";
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
              root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  subvolumes = {
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "@swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = "8G";
                    };
                  };
                };
              };
            };
          };
        };

        secondary = {
          type = "disk";
          device = "/dev/nvme1n1";
          content = {
            type = "gpt";
            partitions = {
              root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  subvolumes = {
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
      };
    };

    fileSystems."/persist".neededForBoot = true;
  };
}
