{
  flake.modules.nixos.home-manager = { inputs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
  };

  flake.modules.darwin.home-manager = { inputs, ... }: {
    imports = [ inputs.home-manager.darwinModules.home-manager ];
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
  };

  flake.modules.homeManager.home-manager =
    { lib, ... }:
    let
      inherit (lib) mkOption types;
    in
    {
      options = {
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
        programs.home-manager.enable = true;
        home.username = "arcohol";
        home.stateVersion = "26.05";
      };
    };
}
