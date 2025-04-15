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

    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    {
      self,
      systems,
      nixpkgs,
      disko,
      home-manager,
      impermanence,
      helix,
      rust-overlay,
      nixos-apple-silicon,
      treefmt-nix,
      ...
    }:
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
          commonModules = [
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            impermanence.nixosModules.impermanence
            ./home
            ./hosts
            ./modules
            ./overlays
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
          nixos-m2 = nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            modules = [
              impermanence.nixosModules.impermanence
              nixos-apple-silicon.nixosModules.apple-silicon-support
              ./hosts/nixos-m2
            ];
          };
        };
    };
}
