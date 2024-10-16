{ persist-path, ... }:

{
  environment.persistence."${persist-path}" = {
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
    ];
  };
}
