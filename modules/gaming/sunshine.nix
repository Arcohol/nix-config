{
  flake.modules.nixos.gaming =
    { pkgs, ... }:
    {
      services.sunshine = {
        enable = true;
        package = pkgs.sunshine.override { cudaSupport = true; };
        autoStart = false;
        capSysAdmin = true; # needed for Wayland
        openFirewall = true;
      };
    };
}
