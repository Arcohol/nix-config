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
  flake.nixosConfigurations = lib.pipe (collectHostsModules config.flake.modules.nixos) [
    (lib.mapAttrs' (
      name: module: {
        # hostname
        name = lib.removePrefix prefix name;
        # nixosSystem
        value = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ module ];
        };
      }
    ))
  ];
}
