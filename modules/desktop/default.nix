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
        experimental-features = "nix-command flakes";
        auto-optimise-store = true;
      };
      nixpkgs.config.allowUnfree = true;

      security.sudo.extraConfig = ''Defaults lecture="never"'';

      networking.networkmanager.enable = true;

      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set -g fish_greeting
        '';
      };

      programs.gnupg.agent.enable = true;

      programs.vim = {
        enable = true;
        defaultEditor = true;
      };

      programs.tmux.enable = true;

      programs.obs-studio = {
        enable = true;
        package = pkgs.obs-studio.override { cudaSupport = true; };
      };

      hardware.logitech.wireless = {
        enable = true;
        enableGraphical = true;
      };

      services.pipewire.enable = true;
      services.playerctld.enable = true;

      time.timeZone = "Europe/Amsterdam";
      i18n.defaultLocale = "en_US.UTF-8";
    };

  flake.modules.darwin.desktop = { pkgs, ... }: {
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
        home.packages = with pkgs; [
          telegram-desktop
          qbittorrent
          spotify
          unrar
          unzip
          p7zip
          ffmpeg
        ];

        home.persist = [
          ".local/share/TelegramDesktop"
          ".local/share/qBittorrent"
          ".local/state/wireplumber"
          ".local/share/fish"
        ];

        programs.firefox.enable = true;
        programs.fish.enable = true;
        programs.starship = {
          enable = true;
          presets = [ "plain-text-symbols" ];
        };
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
    ];
  };
}
