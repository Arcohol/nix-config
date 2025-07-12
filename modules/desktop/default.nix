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

      nixpkgs.config.android_sdk.accept_license = true;

      security.sudo.extraConfig = ''Defaults  lecture="never"'';

      networking.networkmanager.enable = true;

      environment.systemPackages = with pkgs; [
        wget
        curl
      ];

      programs.nix-ld.enable = true;
      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set -g fish_greeting
        '';
      };
      programs.gnupg.agent.enable = true;
      programs.wireshark = {
        enable = true;
        package = pkgs.wireshark;
      };
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

      time.timeZone = "Europe/Amsterdam";
      i18n.defaultLocale = "en_US.UTF-8";

      system.stateVersion = "24.05";
    };

  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      home.packages' = with pkgs; [
        {
          package = telegram-desktop;
          path = [ ".local/share/TelegramDesktop" ];
        }
        {
          package = prismlauncher;
          path = [ ".local/share/PrismLauncher" ];
        }
        spotify
        typora
        calibre
        discord
        screen
        unrar
        ffmpeg
        socat
        iw
        aircrack-ng
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

      home.pointerCursor = {
        enable = true;
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
        size = 24;
      };
    };
}
