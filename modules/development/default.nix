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

  flake.modules.homeManager.development =
    {
      inputs,
      lib,
      pkgs,
      ...
    }:
    {
      home.packages =
        with pkgs;
        [
          arduino-cli
          nixd
          nixfmt
          python3
          codex
          inputs.llm-agents.packages.${stdenv.hostPlatform.system}.chatgpt
        ]
        ++ lib.optionals stdenv.hostPlatform.isLinux [ nrfconnect ];

      home.persist.directories = [
        ".arduino15"
        ".npm"
        ".cmake"
        ".codex"
      ];
    };
}
