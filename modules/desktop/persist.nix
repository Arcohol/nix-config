{
  flake.modules.nixos.desktop =
    { config, ... }:
    {
      preservation.preserveAt."/persist".users.arcohol.directories = [
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
      ]
      ++ config.home-manager.users.arcohol.home.persist;

      systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
      systemd.tmpfiles.settings.preservation = {
        "/home/arcohol/.local".d = {
          user = "arcohol";
          group = "users";
        };
        "/home/arcohol/.local/share".d = {
          user = "arcohol";
          group = "users";
        };
        "/home/arcohol/.local/state".d = {
          user = "arcohol";
          group = "users";
        };
      };
    };
}
