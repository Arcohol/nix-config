{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
  };

  outputs =
    {
      nixpkgs,
      disko,
      home-manager,
      impermanence,
      ...
    }:
    {
      nixosConfigurations =
        let
          commonModules = [
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            impermanence.nixosModules.impermanence
            ./home-manager.nix
            ./impermanence.nix # user-specific
            ./hosts
            ./modules
          ];
        in
        {
          nixos-4800u =
            let
              username = "arcohol";
              hostname = "nixos-4800u";
            in
            nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit username hostname;
              };
              system = "x86_64-linux";
              modules = commonModules;
            };
          nixos-5950x =
            let
              username = "arcohol";
              hostname = "nixos-5950x";
            in
            nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit username hostname;
              };
              system = "x86_64-linux";
              modules = commonModules ++ [
                ./modules/steam.nix
                ./modules/nvidia.nix
              ];
            };
        };
    };
}
