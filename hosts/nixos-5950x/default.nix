{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ./persist.nix
  ];

  nixpkgs.config.allowUnfree = true;

  users.mutableUsers = false;
  users.users.root = {
    hashedPassword = "$y$j9T$VaQvFqUam/c0UEzl0ngKl/$CyiFN/MyCaoBcEzT7MNrmSxJr.6/q08tPu7be4Sqx7.";
    shell = pkgs.fish;
  };
  users.users.arcohol = {
    hashedPassword = "$y$j9T$XYq7YiTT1MU.RK.obCN/81$2EwL2m6ejAx7dP3yoLOEdBf6SzGIhCfitA/ZWx8U489";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB3ckkCQ5z/HmGXztfPLUVI7WyKIoDSMT5tUaFtItE4K arcohol@nixos-4800u"
    ];
    shell = pkgs.fish;
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  swapDevices = [
    {
      device = "/nix/swapfile";
      size = 32 * 1024; # 32 GiB
    }
  ];

  systemd.tmpfiles.rules = [ "L+ /run/gdm/.config/monitors.xml - - - - ${./monitors.xml}" ];
}
