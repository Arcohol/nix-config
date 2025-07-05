{
  flake.modules.nixos."hosts/nixos-m2" = {
    boot.initrd.systemd.enable = true;
    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
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
          {
            directory = "/var/lib/minecraft";
            user = "minecraft";
            group = "minecraft";
          }
          "/var/lib/NetworkManager"
          "/etc/NetworkManager/system-connections"
        ];
        files = [
          {
            file = "/etc/machine-id";
            inInitrd = true;
          }
          {
            file = "/etc/ssh/ssh_host_rsa_key";
            how = "symlink";
          }
          {
            file = "/etc/ssh/ssh_host_ed25519_key";
            how = "symlink";
          }
        ];
        users.arcohol = {
          directories = [ "projects" ];
        };
      };
    };
  };
}
