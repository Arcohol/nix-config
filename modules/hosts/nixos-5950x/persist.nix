{
  flake.modules.nixos."hosts/nixos-5950x" = {
    boot.initrd.systemd.enable = true;
    preservation = {
      enable = true;
      preserveAt."/persist" = {
        commonMountOptions = [ "x-gvfs-hide" ];
        directories = [
          {
            directory = "/var/lib/nixos";
            inInitrd = true;
          }
          "/var/log"
          "/var/lib/systemd"
          "/var/lib/NetworkManager"
          "/var/lib/power-profiles-daemon"
          "/etc/NetworkManager/system-connections"
          "/root/.cache/nix"
        ];
        files = [
          {
            file = "/etc/machine-id";
            inInitrd = true;
          }
        ];
      };
    };
  };
}
