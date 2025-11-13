{ config, ... }:
{
  flake.modules.nixos."hosts/nixos-4800u" =
    { pkgs, ... }:
    {
      imports = with config.flake.modules.nixos; [
        home-manager
        desktop
        waydroid
      ];
      home-manager.users.arcohol.imports = with config.flake.modules.homeManager; [
        home-manager
        desktop
        waydroid

        dev
      ];

      networking.hostName = "nixos-4800u";

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
          };
        };
      };

      swapDevices = [
        {
          device = "/nix/swapfile";
          size = 16 * 1024; # 16 GiB
        }
      ];

      system.stateVersion = "25.05";
    };
}
