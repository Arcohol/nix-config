{ inputs, ... }:
{
  flake.modules.nixos."hosts/nixos-wsl" =
    { pkgs, ... }:
    {
      imports = [ inputs.nixos-wsl.nixosModules.default ];

      wsl.enable = true;
      wsl.defaultUser = "arcohol";

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nixpkgs.hostPlatform = "x86_64-linux";

      networking.hostName = "nixos-wsl";

      environment.systemPackages = with pkgs; [
        git
        wget
        curl
      ];

      system.stateVersion = "26.05";
    };
}
