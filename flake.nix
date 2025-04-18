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
    helix.inputs.rust-overlay.follows = "rust-overlay";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    nixos-apple-silicon.url = "github:tpwrules/nixos-apple-silicon";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      systems,
      nixpkgs,
      disko,
      home-manager,
      impermanence,
      helix,
      rust-overlay,
      nixos-apple-silicon,
      nix-minecraft,
      treefmt-nix,
      ...
    }@inputs:
    let
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
      treefmtEval = eachSystem (
        pkgs:
        treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs.nixfmt = {
            enable = true;
            strict = true;
          };
        }
      );
    in
    {
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
      nixosConfigurations =
        let
          # One username to rule them all
          username = "arcohol";

          # common modules for all destops
          desktopModules = [
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            impermanence.nixosModules.impermanence
            ./home
            ./hosts
            ./modules
            ./overlays
          ];
        in
        {
          nixos-4800u = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs username;
              hostname = "nixos-4800u";
            };
            system = "x86_64-linux";
            modules = desktopModules;
          };
          nixos-5950x = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs username;
              hostname = "nixos-5950x";
            };
            system = "x86_64-linux";
            modules = desktopModules ++ [
              ./modules/steam.nix
              ./modules/nvidia.nix
            ];
          };
          nixos-m2 = nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            modules = [
              impermanence.nixosModules.impermanence
              nixos-apple-silicon.nixosModules.apple-silicon-support
              ./hosts/nixos-m2
              { nixpkgs.overlays = [ nix-minecraft.overlays.default ]; }
            ];
          };
        };
    };
}
