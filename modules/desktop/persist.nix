{
  flake.modules.nixos.desktop =
    { config, ... }:
    {
      environment.persistence."/persist".users.arcohol.directories = [
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Public"
        "Templates"
        "Videos"

        "projects"

        ".config"
        ".cache"
        ".local/state/wireplumber" # audio
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
      ] ++ config.home-manager.users.arcohol.home.persist;
    };
}
