{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports =
    [
      ./hardware-configuration.nix
      ./persist.nix
    ]
    ++ [
      ../../modules/gnome.nix
      ../../modules/i18n.nix
      ../../modules/fonts.nix
      ../../modules/steam.nix
      ../../modules/starship.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos-4800u";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";

  services.pipewire.enable = true;
  services.libinput.enable = true;
  services.mullvad-vpn.enable = true;

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

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
  ];
  environment.variables.EDITOR = "vim";
  environment.etc."nixos".source = "/home/arcohol/projects/nix-config";

  security.sudo.extraConfig = ''Defaults  lecture="never"'';

  system.stateVersion = "24.05";
}
