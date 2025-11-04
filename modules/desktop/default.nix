{
  flake.modules.nixos.desktop =
    { lib, pkgs, ... }:
    {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.systemd-boot.configurationLimit = 10;
      boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
      boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

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

      hardware.logitech.wireless = {
        enable = true;
        enableGraphical = true;
      };

      services.pipewire.enable = true;
      services.mullvad-vpn.enable = true;
      services.playerctld.enable = true;

      time.timeZone = "Europe/Amsterdam";
      i18n.defaultLocale = "en_US.UTF-8";

      system.stateVersion = "24.05";
    };

  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      home.persist = [ ".local/state/wireplumber" ];

      home.packages' = with pkgs; [
        {
          package = telegram-desktop;
          path = [ ".local/share/TelegramDesktop" ];
        }
        spotify
        typora
        discord
        screen
        unrar
        unzip
        p7zip
        ffmpeg
        qbittorrent
      ];

      programs.bash.enable = true;
      programs.fish.enable = true;
      programs.go.enable = true;
      programs.gpg.enable = true;
      programs.yt-dlp.enable = true;

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
    };
}
