{ pkgs, ... }:

{
  imports = [
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
    typescript-language-server

    screen
    unrar
    ffmpeg
  ];

  programs.bash.enable = true;
  programs.direnv.enable = true;
  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.git.enable = true;
  programs.gpg.enable = true;
  programs.helix.enable = true;
  programs.kitty.enable = true;
  programs.mpv.enable = true;
  programs.vscode.enable = true;
  programs.yt-dlp.enable = true;

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
