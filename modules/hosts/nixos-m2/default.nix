{ config, ... }: {
  flake.modules.nixos."hosts/nixos-m2" = { inputs, pkgs, ... }: {
    imports = [
      inputs.preservation.nixosModules.preservation
      inputs.nixos-apple-silicon.nixosModules.apple-silicon-support
    ]
    ++ (with config.flake.modules.nixos; [
      home-manager
      desktop
      niri
      development
    ]);
    home-manager.users.arcohol.imports = with config.flake.modules.homeManager; [
      home-manager
      desktop
      niri
      development
    ];

    networking.hostName = "nixos-m2";

    hardware.asahi.peripheralFirmwareDirectory = ./firmware;
    nixpkgs.config.allowUnsupportedSystem = true;

    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };

    programs.nix-ld.enable = true;

    users = {
      mutableUsers = false;
      users = {
        root.hashedPassword = "$y$j9T$hGcbuGOSJhCYCrbzA339u0$TA0E0Ok76BSWZpkYTvDOXTczOaClhhcCKE03jsgkTl1";
        arcohol = {
          shell = pkgs.fish;
          hashedPassword = "$y$j9T$PFIzFYBDSSOCp8zMUBweg1$5h48073kSIvoptc.jk.CU0rf.lMxjHcfP44yofPDK17";
          isNormalUser = true;
          extraGroups = [
            "wheel"
            "networkmanager"
            "dialout"
          ];
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJIETMAyn5mV1u/zuuy5mWPdJ8WSLE9GuSdg/N0HTWd0 arcohol@nixos-5950x"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFmxhknPCSuJNQ4wzfoDTB/210j97v3NxrODwtmKq69/ arcohol@nixos-4800u"
          ];
        };
      };
    };

    system.stateVersion = "26.05";
  };
}
