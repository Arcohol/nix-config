{ pkgs, username, ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ./persist.nix
  ];

  nixpkgs.config.allowUnfree = true;

  users = {
    mutableUsers = false;
    users = {
      root = {
        hashedPassword = "$y$j9T$VaQvFqUam/c0UEzl0ngKl/$CyiFN/MyCaoBcEzT7MNrmSxJr.6/q08tPu7be4Sqx7.";
        shell = pkgs.fish;
      };
      ${username} = {
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
      size = 16 * 1024; # 16 GiB
    }
  ];

  systemd.tmpfiles.rules = [ "L+ /run/gdm/.config/monitors.xml - - - - ${./monitors.xml}" ];
}
