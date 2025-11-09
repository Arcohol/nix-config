{
  flake.modules.nixos.desktop = {
    services.mullvad-vpn.enable = true;
    preservation.preserveAt."/persist".directories = [
      "/etc/mullvad-vpn"
      "/var/cache/mullvad-vpn"
    ];
  };
}
