{
  flake.modules.nixos.bluetooth = { config, ... }: {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
    preservation.preserveAt.${config.persistence.stateRoot}.directories = [
      "/var/lib/bluetooth"
      "/etc/bluetooth"
    ];
  };
}
