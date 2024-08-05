{ config, pkgs, ... }:

{
  home.username = "arcohol";
  home.homeDirectory = "/home/arcohol";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    # fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    sarasa-gothic
    hack-font
    inter

    nixfmt-rfc-style
  ];

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Tiantian Li";
    userEmail = "i@arcohol.com";
    signing.key = null;
    signing.signByDefault = true;
  };

  programs.bash.enable = true;
  programs.firefox.enable = true;
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  fonts.fontconfig = {
    enable = true;
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
  };
}
