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
    ffmpeg
  ];

  xdg = {
    enable = true;
    configFile = {
      "paperwm/user.css" = {
        text = ''
          .paperwm-selection { background-color: rgba(0, 0, 0, 0); }
        '';
      };
    };
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
