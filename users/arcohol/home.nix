{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../../home/default.nix
    ../../home/dconf.nix
  ];

  home.packages = with pkgs; [
    telegram-desktop
    spotify
    typora

    dconf2nix
    nixfmt-rfc-style
    rustup
    gcc
    cargo-tarpaulin
  ];

  programs.bash.enable = true;
  programs.firefox.enable = true;
  programs.gpg.enable = true;
  programs.mpv.enable = true;
  programs.vscode.enable = true;
  programs.git = {
    enable = true;
    userName = "Tiantian Li";
    userEmail = "i@arcohol.com";
    signing.key = null;
    # signing.signByDefault = true;
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
    '';
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
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
