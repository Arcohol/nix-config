{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../modules/gnome.nix
    ../modules/i18n.nix
    ../modules/fonts.nix
    ../modules/steam.nix
    ../modules/starship.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowAliases = false;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

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

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
  ];

  services.pipewire.enable = true;
  services.libinput.enable = true;
  services.mullvad-vpn.enable = true;

  programs.fish.enable = true;

  environment.variables.EDITOR = "vim";
  environment.etc."nixos".source = "/home/arcohol/projects/nix-config";

  security.sudo.extraConfig = ''Defaults  lecture="never"'';

  system.stateVersion = "24.05";
}
