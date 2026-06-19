{ config, ... }: {
  flake.modules.darwin."hosts/darwin-m5" = { pkgs, ... }: {
    imports = with config.flake.modules.darwin; [ home-manager ];
    home-manager.users.arcohol.imports = with config.flake.modules.homeManager; [
      home-manager
      development
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    nixpkgs.config.allowUnfree = true;
    nixpkgs.hostPlatform = "aarch64-darwin";
    networking.hostName = "darwin-m5";

    users.users.arcohol.home = "/Users/arcohol";

    environment.systemPackages = with pkgs; [ neovim ];

    system.stateVersion = 7;
  };
}
