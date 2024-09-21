{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../common.nix
    ./disko.nix
    ./hardware-configuration.nix
    ./persist.nix
  ];

  networking.hostName = "nixos-5950x";

  users.mutableUsers = false;
  users.users.root = {
    hashedPassword = "$y$j9T$VaQvFqUam/c0UEzl0ngKl/$CyiFN/MyCaoBcEzT7MNrmSxJr.6/q08tPu7be4Sqx7.";
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
}
