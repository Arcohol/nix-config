{
  flake.modules.nixos."hosts/nixos-4800u" =
    let
      disk0 = "/dev/disk/by-id/nvme-ZHITAI_TiPlus7100_1TB_ZTA41T0BA231969YFK";
    in
    {
      disko.devices = {
        nodev."/" = {
          fsType = "tmpfs";
          mountOptions = [
            "defaults"
            "size=8G"
            "mode=755"
          ];
        };

        disk.main = {
          device = disk0;
          type = "disk";
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
