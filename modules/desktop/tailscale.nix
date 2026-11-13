{
  flake.modules.nixos.tailscale = { config, ... }: {
    services.tailscale.enable = true;
    preservation.preserveAt.${config.persistence.stateRoot}.directories = [ "/var/lib/tailscale" ];
  };

  flake.modules.darwin.tailscale = {
    services.tailscale.enable = true;
  };
}
