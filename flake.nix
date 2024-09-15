{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      home-manager,
      impermanence,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        nixos-4800u =
          let
            username = "arcohol";
          in
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./hosts/nixos-4800u
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {
                  inherit username;
                };
                home-manager.users.${username} = import ./users/${username}/home.nix;
              }
              impermanence.nixosModules.impermanence
            ];
          };
        nixos-5950x =
          let
            username = "arcohol";
          in
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./hosts/nixos-5950x
              disko.nixosModules.disko
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = {
                  inherit username;
                };
                home-manager.users.${username} = import ./users/${username}/home.nix;
              }
              impermanence.nixosModules.impermanence
            ];
          };
      };
    };
}
