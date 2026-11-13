{
  flake.modules.nixos.home-manager = { inputs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.extraSpecialArgs = { inherit inputs; };
  };

  flake.modules.darwin.home-manager = { inputs, ... }: {
    imports = [ inputs.home-manager.darwinModules.home-manager ];
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.extraSpecialArgs = { inherit inputs; };
  };

  flake.modules.homeManager.home-manager = {

    config = {
      programs.home-manager.enable = true;
      home.username = "arcohol";
      home.stateVersion = "26.05";
    };
  };
}
