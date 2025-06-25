{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) hasSuffix lists;
  inherit (builtins) filter attrNames readDir;

  nixFilesIn =
    dir: map (name: dir + "/${name}") (filter (name: hasSuffix ".nix" name) (attrNames (readDir dir)));
in
{
  imports = (nixFilesIn ./programs) ++ [ ./fonts.nix ];

  # home.packages' -> home.packages
  home.packages = map (entry: entry.package) config.home.packages';

  # home.packages' -> home.persist
  home.persist = lists.concatMap (entry: entry.path) config.home.packages';

  home.packages' = with pkgs; [
    {
      package = telegram-desktop;
      path = [ ".local/share/TelegramDesktop" ];
    }
    {
      package = prismlauncher;
      path = [ ".local/share/PrismLauncher" ];
    }
    spotify
    typora
    calibre
    discord

    # Development
    {
      package = android-studio;
      path = [
        ".android"
        ".local/share/Google"
      ];
    }
    (rust-bin.stable.latest.default.override {
      extensions = [
        "rust-analyzer"
        "rust-src"
      ];
    })
    nixfmt-rfc-style
    gcc
    (python3.withPackages (
      python-pkgs: with python-pkgs; [
        requests
        pandas
        numpy
      ]
    ))
    uv
    ruff
    nodejs
    nixd
    typescript-language-server
    vscode-langservers-extracted

    # Tools
    screen
    unrar
    ffmpeg
    socat
    iw
    aircrack-ng
    qbittorrent
  ];

  programs.bash.enable = true;
  programs.go.enable = true;
  programs.gpg.enable = true;
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

  home.pointerCursor = {
    enable = true;
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };
}
