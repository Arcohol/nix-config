{ pkgs, ... }:

{
  imports = [
    ./programs
    ./fonts.nix
  ];

  home.packages = with pkgs; [
    telegram-desktop
    spotify
    typora

    nixfmt-rfc-style
    rustup
    gcc
    python3
    ruff
    nodejs
    nixd

    screen
    unrar
  ];

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
