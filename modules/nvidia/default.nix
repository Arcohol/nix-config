{
  flake.modules.nixos.nvidia =
    { config, ... }:
    {
      # environment.variables.GSK_RENDERER = "ngl"; # Otherwise GTK4 apps won't quit
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        open = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
      };
    };
}
