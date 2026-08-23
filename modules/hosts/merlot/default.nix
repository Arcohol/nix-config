{ config, ... }: {
  flake.modules.nixos."hosts/merlot" = { pkgs, ... }: {
    imports = with config.flake.modules.nixos; [
      home-manager
      desktop
      niri
      gaming
      development
      waydroid
    ];
    home-manager.users.arcohol.imports = with config.flake.modules.homeManager; [
      home-manager
      desktop
      niri
      gaming
      development
      waydroid
    ];

    networking.hostName = "merlot";

    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };

    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.open = true;

    users = {
      mutableUsers = false;
      users = {
        root = {
          hashedPassword = "$y$j9T$VaQvFqUam/c0UEzl0ngKl/$CyiFN/MyCaoBcEzT7MNrmSxJr.6/q08tPu7be4Sqx7.";
          shell = pkgs.fish;
        };

        arcohol = {
          hashedPassword = "$y$j9T$XYq7YiTT1MU.RK.obCN/81$2EwL2m6ejAx7dP3yoLOEdBf6SzGIhCfitA/ZWx8U489";
          isNormalUser = true;
          extraGroups = [
            "wheel"
            "networkmanager"
            "dialout"
          ];
          shell = pkgs.fish;
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOIHS9+5QgJfjis43PQ/UgDLy2ViHHBkHhl+N6f1DGfb highball"
          ];
        };
      };
    };

    system.stateVersion = "26.05";
  };
}
