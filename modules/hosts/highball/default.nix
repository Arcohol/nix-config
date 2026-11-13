{ config, ... }: {
  flake.modules.darwin."hosts/highball" = {
    imports = with config.flake.modules.darwin; [
      home-manager
      arcohol
      desktop
      development
    ];
    home-manager.users.arcohol.imports = with config.flake.modules.homeManager; [
      home-manager
      arcohol
      desktop
      development
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    nixpkgs.config.allowUnfree = true;
    nixpkgs.hostPlatform = "aarch64-darwin";
    networking.hostName = "highball";

    system.stateVersion = 7;
  };
}
