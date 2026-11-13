{
  flake.modules.homeManager.persistence =
    { lib, ... }:
    let
      inherit (lib) mkOption types;
    in
    {
      options = {
        home.persist = {
          directories = mkOption {
            default = [ ];
            type =
              let
                inherit (types) listOf str;
              in
              listOf str;
            description = "A list of directories to persist.";
          };

          files = mkOption {
            default = [ ];
            type =
              let
                inherit (types) listOf str;
              in
              listOf str;
            description = "A list of files to persist.";
          };
        };
      };

    };
}
