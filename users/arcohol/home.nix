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

    dconf2nix
    nixfmt-rfc-style
    rustup
    gcc
  ];

  programs.bash.enable = true;
  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.gpg.enable = true;
  programs.mpv.enable = true;
  programs.vscode.enable = true;
  programs.git = {
    enable = true;
    userName = "Tiantian Li";
    userEmail = "i@arcohol.com";
    signing.key = null;
    signing.signByDefault = true;
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
}
