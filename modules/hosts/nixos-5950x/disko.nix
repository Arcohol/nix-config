{
  flake.modules.nixos."hosts/nixos-5950x" = {
    disko.devices = {
      disk = {
        main = {
          device = "/dev/nvme0n1";
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
                  mountOptions = [
                    "fmask=0077"
                    "dmask=0077"
                  ];
                };
              };
              nix = {
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/nix";
                };
              };
            };
          };
        };
        sata = {
          device = "/dev/sda";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              persist = {
                size = "200G";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/persist";
                };
              };
            };
          };
        };
      };
      nodev = {
        "/" = {
          fsType = "tmpfs";
          mountOptions = [
            "defaults"
            "size=50%"
            "mode=755"
          ];
        };
      };
    };

    fileSystems."/persist".neededForBoot = true;
  };
}
