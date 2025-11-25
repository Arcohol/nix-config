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
          ];

          files = [
            {
              file = "/etc/machine-id";
              inInitrd = true;
            }
          ];

          users.root.directories = [ ".cache/nix" ];

          users.arcohol.directories = config.home-manager.users.arcohol.home.persist ++ [
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
        };

        preserveAt."/storage" = {
          commonMountOptions = [ "x-gvfs-hide" ];

          users.arcohol.directories = [
            "Desktop"
            "Downloads"
            "Documents"
            "Music"
            "Pictures"
            "Videos"
          ];
        };
      };

      systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
    };
}
