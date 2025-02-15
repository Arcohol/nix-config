{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    helix.url = "github:helix-editor/helix";
    helix.inputs.nixpkgs.follows = "nixpkgs";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      disko,
      home-manager,
      impermanence,
      helix,
      rust-overlay,
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
            {
              nix.settings = {
                substituters = [ "https://cache.garnix.io" ];
                trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
              };
            }
            { home-manager.extraSpecialArgs = { inherit helix; }; }
            { nixpkgs.overlays = [ rust-overlay.overlays.default ]; }
          ];
        in
        {
          nixos-4800u =
            let
              username = "arcohol";
              hostname = "nixos-4800u";
            in
            nixpkgs.lib.nixosSystem {
              specialArgs = { inherit username hostname; };
              system = "x86_64-linux";
              modules = commonModules;
            };
          nixos-5950x =
            let
              username = "arcohol";
              hostname = "nixos-5950x";
            in
            nixpkgs.lib.nixosSystem {
              specialArgs = { inherit username hostname; };
              system = "x86_64-linux";
              modules = commonModules ++ [
                ./modules/steam.nix
                ./modules/nvidia.nix
              ];
            };
        };
    };
}
