{
  flake.modules.nixos.tailscale = {
    services.tailscale.enable = true;
    preservation.preserveAt."/persist".directories = [ "/var/lib/tailscale" ];
  };

  flake.modules.darwin.tailscale = {
    services.tailscale.enable = true;
  };
}
