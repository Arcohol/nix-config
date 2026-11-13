{
  flake.modules.nixos.arcohol = { config, lib, ... }: {
    config = lib.mkMerge [
      {
        preservation.preserveAt.${config.persistence.stateRoot}.users.arcohol.directories = [
          ".config"
          ".cache"
          {
            directory = ".gnupg";
            mode = "0700";
          }
          {
            directory = ".ssh";
            mode = "0700";
          }
          {
            directory = ".local/share/keyrings";
            mode = "0700";
          }
        ];
      }
      {
        preservation.preserveAt.${config.persistence.dataRoot} = {
          users.arcohol.directories = [
            "Desktop"
            "Downloads"
            "Documents"
            "Music"
            "Pictures"
            "Projects"
            "Videos"
          ];
        };
      }
    ];
  };
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
