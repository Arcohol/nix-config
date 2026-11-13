{
  flake.modules.nixos.bluetooth = {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
    preservation.preserveAt."/persist".directories = [
      "/var/lib/bluetooth"
      "/etc/bluetooth"
    ];
  };
}
