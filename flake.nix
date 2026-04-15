{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    preservation.url = "github:nix-community/preservation";

    nixos-apple-silicon.url = "github:nix-community/nixos-apple-silicon";
    nixos-apple-silicon.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    niri.url = "github:niri-wm/niri";
    niri.inputs.nixpkgs.follows = "nixpkgs";
    niri.inputs.rust-overlay.follows = ""; # Upstream only uses it for devShells
  };

  outputs =
    { nixpkgs, flake-parts, ... }@inputs:
    let
      inherit (nixpkgs) lib;
      nixFilesIn = dir: lib.filter (f: lib.hasSuffix ".nix" f) (lib.filesystem.listFilesRecursive dir);
    in
    flake-parts.lib.mkFlake { inherit inputs; } { imports = nixFilesIn ./modules; };
}
