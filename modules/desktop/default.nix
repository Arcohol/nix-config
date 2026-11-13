{ config, ... }:
let
  flakeConfig = config;
in
{
  flake.modules.nixos.desktop = { config, ... }: {
    imports = with flakeConfig.flake.modules.nixos; [
      shell
      audio
      fonts
      tailscale
      bluetooth
    ];

    security.sudo.extraConfig = ''Defaults lecture="never"'';

    preservation.preserveAt.${config.persistence.stateRoot}.directories = [
      "/var/lib/NetworkManager"
      "/etc/NetworkManager/system-connections"
      "/var/lib/power-profiles-daemon"
    ];
    networking.networkmanager.enable = true;
  };

  flake.modules.darwin.desktop = {
    system.defaults = {
      dock = {
        autohide = true;
        show-recents = false;
        tilesize = 56;
      };
      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        AppleTemperatureUnit = "Celsius";
      };
      CustomUserPreferences = {
        "com.apple.dock" = {
          "no-bouncing" = true;
        };
      };
    };

    imports = with flakeConfig.flake.modules.darwin; [
      shell
      fonts
      tailscale
    ];
  };

  flake.modules.homeManager.desktop = { lib, pkgs, ... }: {
    imports = [ flakeConfig.flake.modules.homeManager.shell ];
    config = lib.mkMerge [
      # Common settings
      {
        home.packages = with pkgs; [
          qbittorrent
          spotify
          unrar
          unzip
          p7zip
          ffmpeg
          neovim
          screen
          gh
          google-chrome
        ];

        home.persist.directories = [
          ".local/share/TelegramDesktop"
          ".local/share/qBittorrent"
          ".local/state/wireplumber"
        ];

        home.sessionVariables = {
          EDITOR = "nvim";
        };

      }

      # Linux-specific settings
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
        home.packages = with pkgs; [
          discord
          telegram-desktop
        ];

        programs.firefox.enable = true;

        gtk = {
          enable = true;
          theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome-themes-extra;
          };
          iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
          };
        };

        qt = {
          enable = true;
          platformTheme.name = "gtk3";
        };

        home.pointerCursor = {
          enable = true;
          name = "Adwaita";
          package = pkgs.adwaita-icon-theme;
          size = 24;
        };
      })

      # Darwin-specific settings
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
        home.packages = with pkgs; [ caffeine ];
        programs.man.generateCaches = false;
      })
    ];
  };
}
