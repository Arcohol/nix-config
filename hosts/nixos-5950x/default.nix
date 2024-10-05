{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports =
    [
      ../common.nix
      ./disko.nix
      ./hardware-configuration.nix
      ./persist.nix
    ]
    ++ [
      ../../modules/gnome.nix
      ../../modules/fonts.nix
    ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos-5950x";

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

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
}
