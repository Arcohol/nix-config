{ persistPath, ... }:

{
  environment.persistence."${persistPath}" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd"
      "/var/lib/NetworkManager"
      "/var/lib/power-profiles-daemon"
      "/etc/NetworkManager/system-connections"
      "/etc/mullvad-vpn"
      "/var/cache/mullvad-vpn"
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };
}
