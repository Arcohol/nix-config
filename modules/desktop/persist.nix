{
  flake.modules.nixos.desktop =
    { config, ... }:
    {
      boot.initrd.systemd.enable = true;
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
            "/root/.cache/nix"
          ];

          files = [
            {
              file = "/etc/machine-id";
              inInitrd = true;
            }
          ];

          users.arcohol.directories = [
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
        };
      };

      systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
    };
}
