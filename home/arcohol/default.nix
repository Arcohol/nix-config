{ lib, pkgs, ... }:

let
  inherit (lib) hasSuffix;
  inherit (builtins) filter attrNames readDir;

  nixFilesIn =
    dir: map (name: dir + "/${name}") (filter (name: hasSuffix ".nix" name) (attrNames (readDir dir)));
in
{
  imports = (nixFilesIn ./programs) ++ [ ./fonts.nix ];

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
    prismlauncher
  ];

  programs.bash.enable = true;
  programs.firefox.enable = true;
  programs.go.enable = true;
  programs.gpg.enable = true;
  programs.vscode.enable = true;
  programs.yt-dlp.enable = true;

  xdg = {
    enable = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
