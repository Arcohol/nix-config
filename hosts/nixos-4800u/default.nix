{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./..
    ./hardware-configuration.nix
    ./persist.nix
  ];
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos-4800u";

  users.mutableUsers = false;
  users.users = {
    arcohol = {
      hashedPassword = "$y$j9T$XYq7YiTT1MU.RK.obCN/81$2EwL2m6ejAx7dP3yoLOEdBf6SzGIhCfitA/ZWx8U489";
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      shell = pkgs.fish;
    };
    root.hashedPassword = "$y$j9T$VaQvFqUam/c0UEzl0ngKl/$CyiFN/MyCaoBcEzT7MNrmSxJr.6/q08tPu7be4Sqx7.";
  };

  systemd.tmpfiles.rules = [ "L+ /run/gdm/.config/monitors.xml - - - - ${./monitors.xml}" ];
}
