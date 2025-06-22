{
  programs.niri.settings = null;
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        icon-theme = "Papirus-Dark";
      };
    };
  };
  home.persist = [ ".local/share/fcitx5" ];
}
