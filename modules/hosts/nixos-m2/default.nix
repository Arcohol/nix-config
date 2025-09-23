{ inputs, ... }:
{
  flake.modules.nixos."hosts/nixos-m2" =
    { pkgs, ... }:
    {
      imports = [
        inputs.preservation.nixosModules.preservation
        inputs.nixos-apple-silicon.nixosModules.apple-silicon-support
      ];

      boot.loader.systemd-boot.enable = true;
      hardware.asahi.peripheralFirmwareDirectory = ./firmware;

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
            ];
            openssh.authorizedKeys.keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSjGCbvsPzEl3k3WaI6N41+jWPeA+Qtj8zIkdQmmLfz arcohol@nixos-5950x"
            ];
          };
        };
      };

      environment.enableAllTerminfo = true;
      environment.systemPackages = with pkgs; [
        wget
        curl
        git
        jdk17
        tmux
      ];

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

      time.timeZone = "Europe/Amsterdam";
      i18n.defaultLocale = "en_US.UTF-8";

      networking.hostName = "nixos-m2";
      networking.networkmanager.enable = true;

      system.stateVersion = "25.05";
    };
}
