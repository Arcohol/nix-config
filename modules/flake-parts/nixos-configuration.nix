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
  flake.nixosConfigurations = lib.mapAttrs' (
    hostname: module:
    lib.nameValuePair (lib.removePrefix prefix hostname) (
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [ module ];
      }
    )
  ) (collectHostsModules config.flake.modules.nixos);
}
