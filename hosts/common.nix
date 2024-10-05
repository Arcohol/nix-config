{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nixpkgs.config.allowAliases = false;

  security.sudo.extraConfig = ''Defaults  lecture="never"'';

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
  ];
  environment.variables.EDITOR = "vim";
  environment.etc."nixos".source = "/home/arcohol/projects/nix-config";

  programs.fish.enable = true;
  programs.starship = {
    enable = true;
    presets = [ "plain-text-symbols" ];
  };

  services.pipewire.enable = true;
  services.mullvad-vpn.enable = true;

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "24.05";
}
