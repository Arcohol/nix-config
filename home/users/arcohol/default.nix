{ pkgs, ... }:

{
  imports = [
    ./dconf.nix
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
    nodejs
    nixd
    screen
    unrar
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
      save-position-on-quit = true;
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
      wayland_enable_ime = "no";
    };
    shellIntegration.mode = "no-cursor";
  };

  programs.zed-editor = {
    enable = true;
    extensions = [
      "github-theme"
      "nix"
    ];
    userSettings = {
      theme = "Github Dark";
      vim_mode = true;
      cursor_blink = false;
      terminal = {
        env = {
          TERM = "xterm-256color";
        };
      };
      git = {
        inline_blame = {
          enabled = false;
        };
      };
      autosave = {
        after_delay = {
          milliseconds = 1000;
        };
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
