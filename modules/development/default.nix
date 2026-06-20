{
  flake.modules.nixos.development = { pkgs, ... }: {
    nixpkgs.config.segger-jlink.acceptLicense = true;
    nixpkgs.config.permittedInsecurePackages = [ "segger-jlink-qt4-874" ];
    services.udev.packages = with pkgs; [
      nrf-udev
      segger-jlink
    ];
  };

  flake.modules.darwin.development = { };

  flake.modules.homeManager.development = { pkgs, ... }: {
    home.packages = with pkgs; [
      arduino-cli
      nixd
      nixfmt
      python3
    ];

    home.persist = [
      ".arduino15"
      ".npm" # slop
      ".cmake"
      ".codex"
      ".claude"
    ];

    programs.claude-code.enable = true;
  };
}
