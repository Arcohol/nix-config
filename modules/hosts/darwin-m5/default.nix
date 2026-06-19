{ config, ... }: {
  flake.modules.darwin."hosts/darwin-m5" = { pkgs, ... }: {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    nixpkgs.hostPlatform = "aarch64-darwin";
    networking.hostName = "darwin-m5";

    environment.systemPackages = with pkgs; [ neovim ];

    system.stateVersion = 7;
  };
}
