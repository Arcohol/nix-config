{ pkgs, ... }:

{
  imports = [ ./fonts.nix ];

  home.packages = with pkgs; [
    telegram-desktop
    spotify
    typora
    calibre

    (rust-bin.stable.latest.default.override {
      extensions = [
        "rust-analyzer"
        "rust-src"
      ];
    })
    nixfmt-rfc-style
    gcc
    python3
    uv
    ruff
    nodejs
    nixd
    typescript-language-server
    vscode-langservers-extracted

    screen
    unrar
    ffmpeg
    socat
    iw
    aircrack-ng
    qbittorrent
  ];

  programs.bash.enable = true;
  programs.direnv.enable = true;
  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.go.enable = true;
  programs.git.enable = true;
  programs.gpg.enable = true;
  programs.helix.enable = true;
  programs.kitty.enable = true;
  programs.mpv.enable = true;
  programs.vscode.enable = true;
  programs.yt-dlp.enable = true;

  xdg = {
    enable = true;
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
