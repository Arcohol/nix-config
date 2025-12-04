{
  flake.modules.nixos.development =
    { pkgs, ... }:
    {
      programs.nix-ld.enable = true;
      nixpkgs.config.segger-jlink.acceptLicense = true;
      nixpkgs.config.permittedInsecurePackages = [ "segger-jlink-qt4-874" ];
      services.udev.packages = [
        pkgs.nrf-udev
        pkgs.segger-jlink
      ];
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
