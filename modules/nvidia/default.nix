{
  flake.modules.nixos.nvidia = {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.open = true;
  };
}
