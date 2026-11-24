{
  flake.modules.nixos.persistence =
    { config, inputs, ... }:
    let
      homePersist = config.home-manager.users.arcohol.home.persist;
    in
    {
      imports = [ inputs.preservation.nixosModules.preservation ];
      preservation = {
        enable = true;
        preserveAt."/persist" = {
          commonMountOptions = [ "x-gvfs-hide" ];

          directories = [
            {
              directory = "/var/lib/nixos";
              inInitrd = true;
            }
            "/var/log"
            "/var/lib/systemd"
            "/var/lib/NetworkManager"
            "/var/lib/power-profiles-daemon"
            "/etc/NetworkManager/system-connections"
          ];

          files = [
            {
              file = "/etc/machine-id";
              inInitrd = true;
            }
          ];

          users.root = {
            directories = [ ".cache/nix" ];
          };

          users.arcohol = {
            directories = homePersist.directories ++ [
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
              "Desktop"
              "Downloads"
              "Documents"
              "Music"
              "Pictures"
              "Projects"
              "Videos"
            ];
            files = homePersist.files;
          };
        };

      };

      systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
    };
}
