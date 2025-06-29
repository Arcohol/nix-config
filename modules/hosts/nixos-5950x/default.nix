{ inputs, config, ... }:
{
  flake.modules.nixos."hosts/nixos-5950x" =
    { pkgs, ... }:
    {
      imports =
        [
          inputs.disko.nixosModules.disko
          inputs.impermanence.nixosModules.impermanence
        ]
        ++ (with config.flake.modules.nixos; [
          overlays
          home-manager
          desktop
          nvidia
          steam
        ]);
      home-manager.users.arcohol.imports = with config.flake.modules.homeManager; [
        desktop
        dev
        steam
      ];

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
              "wireshark"
            ];
            shell = pkgs.fish;
          };
        };
      };

      swapDevices = [
        {
          device = "/nix/swapfile";
          size = 32 * 1024; # 32 GiB
        }
      ];

      systemd.tmpfiles.rules = [ "L+ /run/gdm/.config/monitors.xml - - - - ${./monitors.xml}" ];
    };
}
