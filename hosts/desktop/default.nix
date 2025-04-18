{
  lib,
  pkgs,
  hostname,
  ...
}:

{
  imports = [ ./${hostname} ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    substituters = [ "https://cache.garnix.io" ];
    trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
  };

  security.sudo.extraConfig = ''Defaults  lecture="never"'';

  networking.hostName = "${hostname}";
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    curl
  ];

  programs.nix-ld.enable = true;
  programs.fish.enable = true;
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
  programs.starship = {
    enable = true;
    presets = [ "plain-text-symbols" ];
  };
  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  services.pipewire.enable = true;
  services.mullvad-vpn.enable = true;

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "24.05";
}
