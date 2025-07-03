{
  flake.modules.nixos."hosts/nixos-m2" = {
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
          "/etc/ssh/ssh_host_rsa_key"
          "/etc/ssh/ssh_host_rsa_key.pub"
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_ed25519_key.pub"
        ];
        users.arcohol = {
          directories = [ "projects" ];
        };
      };
    };
  };
}
