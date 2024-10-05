{
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd"
      "/etc/NetworkManager/system-connections"
      "/etc/mullvad-vpn"
    ];
    files = [ "/etc/machine-id" ];
    users.arcohol = import ../../home/users/arcohol/persist.nix;
  };
}
