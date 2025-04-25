{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./persist.nix
  ];

  boot.loader.systemd-boot.enable = true;

  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    substituters = [ "https://cache.garnix.io" ];
    trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
  };

  security.sudo.extraConfig = ''Defaults  lecture="never"'';

  users = {
    mutableUsers = false;
    users = {
      root = {
        hashedPassword = "$y$j9T$hGcbuGOSJhCYCrbzA339u0$TA0E0Ok76BSWZpkYTvDOXTczOaClhhcCKE03jsgkTl1";
      };
      arcohol = {
        shell = pkgs.fish;
        hashedPassword = "$y$j9T$PFIzFYBDSSOCp8zMUBweg1$5h48073kSIvoptc.jk.CU0rf.lMxjHcfP44yofPDK17";
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
          "minecraft"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ/1li2cVCBFoipi1epdRrnX552TfTdCuXQbkw8jP4Lp arcohol@nixos-4800u"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJX++6pSJQfIL/+qWLC6IWL8UeEGMgiwH9BmNtQckAIL arcohol@nixos-5950x"
        ];
      };
    };
  };

  environment.enableAllTerminfo = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
    '';
  };
  programs.starship = {
    enable = true;
    presets = [ "plain-text-symbols" ];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  networking.firewall = {
    allowedTCPPorts = [
      80
      443
      25565
    ];
    allowedUDPPorts = [ 25565 ];
  };

  # services.minecraft-server = {
  #   enable = true;
  #   eula = true;
  #   package = pkgs.vanillaServers.vanilla-25w16a;
  #   openFirewall = true;
  # };

  networking = {
    interfaces = {
      end0 = {
        ipv4.addresses = [
          {
            address = "192.168.2.1";
            prefixLength = 24;
          }
        ];
      };
    };
  };

  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    virtualHosts."sogeek.me" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://192.168.2.99:9090";
        proxyWebsockets = true;
        recommendedProxySettings = true;
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "i@arcohol.com";
  };

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  networking.hostName = "nixos-m2";
  networking.networkmanager.enable = true;

  system.stateVersion = "25.05";
}
