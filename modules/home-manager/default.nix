{ inputs, ... }:
{
  flake.modules.nixos.home-manager = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
  };

  flake.modules.homeManager.home-manager =
    {
      config,
      lib,
      osConfig,
      ...
    }:
    let
      inherit (lib) mkOption types;
    in
    {
      options = {
        home.packages' = mkOption {
          default = [ ];
          type =
            let
              inherit (types)
                listOf
                submodule
                package
                coercedTo
                ;
              hmPackage = submodule {
                options = {
                  package = mkOption {
                    type = package;
                    description = "The package to install.";
                  };
                  path = mkOption {
                    default = [ ];
                    type = listOf types.str;
                    description = "The path(s) to persist.";
                  };
                };
              };
            in
            listOf (coercedTo package (p: { package = p; }) hmPackage);
          description = "A list of packages to install.";
        };

        home.persist = mkOption {
          default = [ ];
          type =
            let
              inherit (types) listOf str;
            in
            listOf str;
          description = "A list of paths to persist.";
        };
      };

      config = {
        home.username = "arcohol";
        home.homeDirectory = "/home/arcohol";
        home.stateVersion = osConfig.system.stateVersion;
        programs.home-manager.enable = true;

        # home.packages' -> home.packages
        home.packages = map (entry: entry.package) config.home.packages';

        # home.packages' -> home.persist
        home.persist = lib.lists.concatMap (entry: entry.path) config.home.packages';
      };
    };
}
