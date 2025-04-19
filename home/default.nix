{
  config,
  lib,
  inputs,
  username,
  persistPath,
  ...
}:

{
  # Home Manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    helix = inputs.helix;
  };
  home-manager.users.${username} =
    let
      inherit (lib) mkOption types;
    in
    {
      options = {
        home.packages' = mkOption {
          default = [ ];
          type =
            let
              inherit (types) listOf submodule package;
            in
            listOf (submodule {
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
            });
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

      imports = [ ./${username} ];

      config = {
        home.username = "${username}";
        home.homeDirectory = "/home/${username}";
        home.stateVersion = "24.05";

        programs.home-manager.enable = true;
      };
    };

  # Impermanence
  environment.persistence.${persistPath}.users.${username} =
    (import ./${username}/persist.nix)
      config.home-manager.users.${username}.home.persist;
}
