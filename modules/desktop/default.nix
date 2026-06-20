{
  flake.modules.nixos.desktop =
    {
      inputs,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.disko.nixosModules.disko
        inputs.preservation.nixosModules.preservation
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.systemd-boot.configurationLimit = 10;
      boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

      nix.settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        auto-optimise-store = true;
        substituters = [ "https://cache.garnix.io" ];
        trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
      };

      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowBroken = true;

      security.sudo.extraConfig = ''Defaults lecture="never"'';

      networking.networkmanager.enable = true;

      environment.systemPackages = with pkgs; [
        wget
        curl
      ];

      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set -g fish_greeting
        '';
      };

      programs.gnupg.agent.enable = true;

      programs.starship = {
        enable = true;
        presets = [ "plain-text-symbols" ];
      };

      programs.vim = {
        enable = true;
        defaultEditor = true;
      };

      programs.firefox.enable = true;

      hardware.logitech.wireless = {
        enable = true;
        enableGraphical = true;
      };

      services.pipewire.enable = true;
      services.playerctld.enable = true;
      services.avahi = {
        enable = true;
        nssmdns4 = true;
      };

      time.timeZone = "Europe/Amsterdam";
      i18n.defaultLocale = "en_US.UTF-8";
    };

  flake.modules.darwin.desktop = { pkgs, ... }: {
    system.defaults = {
      dock.autohide = true;
      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        AppleTemperatureUnit = "Celsius";
      };
    };

    system.primaryUser = "arcohol";

    users.users.arcohol = {
      uid = 501;
      shell = pkgs.fish;
      home = "/Users/arcohol";
    };
    users.knownUsers = [ "arcohol" ];

    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting
      '';
    };
  };

  flake.modules.homeManager.desktop = { lib, pkgs, ... }: {
    config = lib.mkMerge [
      # Common settings
      {
        home.packages' = with pkgs; [
          {
            package = telegram-desktop;
            path = [ ".local/share/TelegramDesktop" ];
          }
          {
            package = qbittorrent;
            path = [ ".local/share/qBittorrent" ];
          }
          spotify
          unrar
          unzip
          p7zip
          ffmpeg
        ];

        home.persist = [
          ".local/state/wireplumber"
          ".local/share/fish"
        ];

        programs.firefox.enable = true;
        programs.gpg.enable = true;
      }

      # Linux-specific settings
      (lib.mkIf pkgs.stdenv.isLinux {
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
      (lib.mkIf pkgs.stdenv.isDarwin {
        programs.ghostty = {
          enable = true;
          package = pkgs.ghostty-bin;
          settings = {
            font-size = 16;
            theme = "Catppuccin Mocha";
          };
        };
      })
    ];
  };
}
