{
  flake.modules.nixos.desktop = {
    services.tailscale.enable = true;
    preservation.preserveAt."/persist".directories = [ "/var/lib/tailscale" ];
  };
}
