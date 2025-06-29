{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";

    rust-overlay.url = "github:oxalica/rust-overlay";

    nixos-apple-silicon.url = "github:tpwrules/nixos-apple-silicon";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    { flake-parts, import-tree, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (import-tree ./modules);

  # outputs =
  #   {
  #     systems,
  #     nixpkgs,
  #     disko,
  #     home-manager,
  #     impermanence,
  #     niri,
  #     helix,
  #     rust-overlay,
  #     nixos-apple-silicon,
  #     nix-minecraft,
  #     treefmt-nix,
  #     ...
  #   }@inputs:
  #   let
  #     eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
  #     treefmtEval = eachSystem (
  #       pkgs:
  #       treefmt-nix.lib.evalModule pkgs {
  #         projectRootFile = "flake.nix";
  #         programs.nixfmt = {
  #           enable = true;
  #           strict = true;
  #         };
  #       }
  #     );
  #   in
  #   {
  #     formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
  #     nixosConfigurations =
  #       let
  #         # One username to rule them all
  #         username = "arcohol";

  #         # One path to persist them all
  #         persistPath = "/persist";

  #         # common modules for all destops
  #         desktopModules = [
  #           disko.nixosModules.disko
  #           home-manager.nixosModules.home-manager
  #           impermanence.nixosModules.impermanence
  #           niri.nixosModules.niri
  #           ./home
  #           ./hosts/desktop
  #           ./modules/fonts.nix
  #           ./overlays
  #         ];
  #       in
  #       {
  #         nixos-4800u = nixpkgs.lib.nixosSystem {
  #           specialArgs = {
  #             inherit inputs username persistPath;
  #             hostname = "nixos-4800u";
  #           };
  #           system = "x86_64-linux";
  #           modules = desktopModules ++ [ ./modules/gnome ];
  #         };
  #         nixos-5950x = nixpkgs.lib.nixosSystem {
  #           specialArgs = {
  #             inherit inputs username persistPath;
  #             hostname = "nixos-5950x";
  #           };
  #           system = "x86_64-linux";
  #           modules = desktopModules ++ [
  #             ./modules/niri
  #             ./modules/steam.nix
  #             ./modules/nvidia.nix
  #           ];
  #         };
  #         nixos-m2 = nixpkgs.lib.nixosSystem {
  #           system = "aarch64-linux";
  #           modules = [
  #             impermanence.nixosModules.impermanence
  #             nixos-apple-silicon.nixosModules.apple-silicon-support
  #             ./hosts/server/nixos-m2
  #             { nixpkgs.overlays = [ nix-minecraft.overlays.default ]; }
  #           ];
  #         };
  #       };
  #   };
}
