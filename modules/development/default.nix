{
  flake.modules.nixos.development = { pkgs, ... }: {
    nixpkgs.config.segger-jlink.acceptLicense = true;
    nixpkgs.config.permittedInsecurePackages = [ "segger-jlink-qt4-952" ];
    services.udev.packages = with pkgs; [
      nrf-udev
      segger-jlink
    ];
  };

  flake.modules.darwin.development = { };

  flake.modules.homeManager.development = { inputs, pkgs, ... }: {
    home.packages =
      with pkgs;
      [
        arduino-cli
        nixd
        nixfmt
        python3
      ]
      ++ (with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [ chatgpt ]);

    home.persist.directories = [
      ".arduino15"
      ".npm"
      ".cmake"
      ".codex"
    ];
  };
}
