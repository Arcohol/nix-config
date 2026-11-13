{
  flake.modules.darwin.arcohol = { pkgs, ... }: {
    system.primaryUser = "arcohol";

    users.users.arcohol = {
      uid = 501;
      shell = pkgs.fish;
      home = "/Users/arcohol";
    };
    users.knownUsers = [ "arcohol" ];

  };
  flake.modules.homeManager.arcohol = {
    programs.git.settings.user = {
      name = "Tiantian Li";
      email = "i@arcohol.com";
    };
    home.username = "arcohol";
    home.stateVersion = "26.05";
  };
}
