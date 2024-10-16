{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "${pkgs.alacritty-theme}/github_dark.toml"
      ];
      window.opacity = 0.9;
      font.size = 12;
    };
  };

  # attempt to fix no-cursor issue in alacritty
  xdg.desktopEntries = {
    Alacritty = {
      name = "Alacritty";
      exec = "env XCURSOR_THEME=Adwaita alacritty";
      icon = "Alacritty";
    };
  };
}
