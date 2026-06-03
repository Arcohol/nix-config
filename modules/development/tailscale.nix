{
  flake.modules.nixos.development = {
    services.tailscale.enable = true;
    preservation.preserveAt."/persist".directories = [ "/var/lib/tailscale" ];
  };
}
