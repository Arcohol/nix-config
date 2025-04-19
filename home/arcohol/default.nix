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
    { package = spotify; }
    { package = typora; }
    { package = calibre; }

    # Development
    {
      package = (
        rust-bin.stable.latest.default.override {
          extensions = [
            "rust-analyzer"
            "rust-src"
          ];
        }
      );
    }
    { package = nixfmt-rfc-style; }
    { package = gcc; }
    { package = python3; }
    { package = uv; }
    { package = ruff; }
    { package = nodejs; }
    { package = nixd; }
    { package = typescript-language-server; }
    { package = vscode-langservers-extracted; }

    # Tools
    { package = screen; }
    { package = unrar; }
    { package = ffmpeg; }
    { package = socat; }
    { package = iw; }
    { package = aircrack-ng; }
    { package = qbittorrent; }
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
}
