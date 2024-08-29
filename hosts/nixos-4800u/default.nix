{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./persist.nix
    ../../modules/gnome.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.hostName = "nixos-4800u";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  services.pipewire.enable = true;
  services.libinput.enable = true;
  services.mullvad-vpn.enable = true;

  users.mutableUsers = false;
  users.users.arcohol = {
    hashedPassword = "$y$j9T$XYq7YiTT1MU.RK.obCN/81$2EwL2m6ejAx7dP3yoLOEdBf6SzGIhCfitA/ZWx8U489";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
  users.users.root.hashedPassword = "$y$j9T$VaQvFqUam/c0UEzl0ngKl/$CyiFN/MyCaoBcEzT7MNrmSxJr.6/q08tPu7be4Sqx7.";

  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
  ];
  environment.variables.EDITOR = "vim";
  environment.etc."nixos".source = "/home/arcohol/projects/nix-config";

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    sarasa-gothic
    hack-font
    inter
  ];
  fonts.fontconfig = {
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [
        "Sarasa Term SC"
        "Sarasa Term TC"
        "Hack"
      ];
      sansSerif = [
        "Inter"
        "Noto Sans CJK SC"
        "Noto Sans CJK TC"
      ];
      serif = [
        "Noto Serif"
        "Noto Serif CJK SC"
        "Noto Serif CJK TC"
      ];
    };
    localConf = ''
      <fontconfig>
      <match target="pattern">
        <test qual="any" name="family"><string>Arial</string></test>
        <edit name="family" mode="assign" binding="same"><string>sans-serif</string></edit>
      </match>
      <match target="pattern">
        <test qual="any" name="family"><string>PingFang SC</string></test>
        <edit name="family" mode="assign" binding="same"><string>sans-serif</string></edit>
      </match>
      <match target="pattern">
        <test qual="any" name="family"><string>Microsoft Sans Serif</string></test>
        <edit name="family" mode="assign" binding="same"><string>sans-serif</string></edit>
      </match>
      <match>
        <test compare="contains" name="lang">
        <string>zh_CN</string>
        </test>
        <edit mode="prepend" name="family">
        <string>Noto Sans CJK SC</string>
        </edit>
      </match>
      </fontconfig>
    '';
  };

  system.stateVersion = "24.05";
}
