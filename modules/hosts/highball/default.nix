{ config, ... }: {
  flake.modules.darwin."hosts/highball" = {
    imports = with config.flake.modules.darwin; [
      home-manager
      arcohol
      base
      desktop
      development
    ];
    home-manager.users.arcohol.imports = with config.flake.modules.homeManager; [
      home-manager
      arcohol
      desktop
      development
    ];

    nixpkgs.hostPlatform = "aarch64-darwin";
    networking.hostName = "highball";

    system.stateVersion = 7;
  };
}
