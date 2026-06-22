{
  inputs,
  config,
  lib,
  ...
}:
let
  prefix = "hosts/";
  collectHostsModules = modules: lib.filterAttrs (name: _: lib.hasPrefix prefix name) modules;
in
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.treefmt-nix.flakeModule
  ];

  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "aarch64-darwin"
  ];

  perSystem = {
    treefmt = {
      projectRootFile = "flake.nix";
      programs.nixfmt = {
        enable = true;
        strict = true;
      };
    };
  };

  flake.nixosConfigurations = lib.mapAttrs' (
    hostname: module:
    lib.nameValuePair (lib.removePrefix prefix hostname) (
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [ module ];
      }
    )
  ) (collectHostsModules config.flake.modules.nixos);

  flake.darwinConfigurations = lib.mapAttrs' (
    hostname: module:
    lib.nameValuePair (lib.removePrefix prefix hostname) (
      inputs.nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [ module ];
      }
    )
  ) (collectHostsModules config.flake.modules.darwin);
}
