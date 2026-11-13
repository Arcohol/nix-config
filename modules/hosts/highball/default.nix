{ config, ... }:
let
  flakeConfig = config;
in
{
  flake.modules.darwin."hosts/highball" = {
    imports = with flakeConfig.flake.modules.darwin; [
      home-manager
      arcohol
      base
      desktop
      development
    ];
    home-manager.users.arcohol.imports = with flakeConfig.flake.modules.homeManager; [
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
