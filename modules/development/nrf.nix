{
  flake.modules.nixos.development =
    { pkgs, ... }:
    {
      programs.nix-ld.enable = true;
      nixpkgs.config.segger-jlink.acceptLicense = true;
      services.udev.packages = [ pkgs.nrf-udev ];
    };

  flake.modules.homeManager.development =
    { pkgs, ... }:
    {
      home.persist = [
        "ncs"
        ".cmake"
      ];
      home.packages' = with pkgs; [
        {
          package = nrfutil;
          path = [ ".nrfutil" ];
        }
      ];
    };
}
