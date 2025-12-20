{
  flake.modules.nixos.development =
    { pkgs, ... }:
    {
      nixpkgs.config.segger-jlink.acceptLicense = true;
      nixpkgs.config.permittedInsecurePackages = [ "segger-jlink-qt4-874" ];
      services.udev.packages = with pkgs; [
        nrf-udev
        segger-jlink
      ];
    };

  flake.modules.homeManager.development = {
    home.persist = [
      "ncs"
      ".cmake"
      ".nrfutil"
    ];
  };
}
