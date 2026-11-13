{
  flake.modules.nixos.audio = {
    services.pipewire.enable = true;
    services.playerctld.enable = true;
  };
}
