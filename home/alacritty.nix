{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [
        "${pkgs.alacritty-theme}/github_dark.toml"
      ];
      window.opacity = 0.9;
      font.size = 12;
    };
  };
}
