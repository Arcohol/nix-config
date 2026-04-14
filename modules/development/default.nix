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
  flake.modules.homeManager.development =
    { pkgs, ... }:
    {
      home.packages' = with pkgs; [
        nixd
        nixfmt

        ghc
        haskell-language-server

        gcc
        {
          package = rustup;
          path = [ ".rustup" ];
        }

        python3
      ];

      home.persist = [
        ".cmake"
        ".codex"
      ];
    };
}
