{
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd"
      {
        directory = "/var/lib/minecraft";
        user = "minecraft";
        group = "minecraft";
        mode = "0755";
      }
      "/var/lib/NetworkManager"
      "/var/lib/acme"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
    users.arcohol = {
      directories = [ "projects" ];
    };
  };
}
