{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    telegram-desktop
    spotify
    typora

    dconf2nix
    nixfmt-rfc-style
    rustup
    gcc
    cargo-tarpaulin
    python3
  ];

  programs.bash.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
    '';
  };

  programs.firefox.enable = true;

  programs.gpg.enable = true;

  programs.mpv = {
    enable = true;
    config = {
      profile = "high-quality";
      autofit = "75%";
      sub-auto = "fuzzy";
      audio-file-auto = "fuzzy";
    };
  };

  programs.vscode.enable = true;

  programs.git = {
    enable = true;
    userName = "Tiantian Li";
    userEmail = "i@arcohol.com";
    signing = {
      key = null;
      signByDefault = true;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = 0.8;
      font_size = 12;
    };
    shellIntegration.mode = "no-cursor";
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
