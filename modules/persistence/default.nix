{
  flake.modules.nixos.persistence =
    {
      config,
      inputs,
      lib,
      ...
    }:
    {
      imports = [ inputs.preservation.nixosModules.preservation ];
      options.persistence = {
        stateRoot = lib.mkOption {
          type = lib.types.str;
          description = "Persistent backing directory for system and application state.";
        };
        dataRoot = lib.mkOption {
          type = lib.types.str;
          description = "Persistent backing directory for personal documents and projects.";
        };
      };
      config = {
        preservation = {
          enable = true;
          preserveAt = lib.mkMerge [
            (lib.genAttrs
              (lib.unique [
                config.persistence.stateRoot
                config.persistence.dataRoot
              ])
              (_: {
                commonMountOptions = [ "x-gvfs-hide" ];
              })
            )
            {
              ${config.persistence.stateRoot} = {
                users = lib.mapAttrs (_: home: {
                  directories = home.home.persist.directories;
                  files = home.home.persist.files;
                }) config.home-manager.users;
              };
            }
          ];
        };
        systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
      };
    };
}
