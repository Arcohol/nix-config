{ pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [ autoload ];
    config = {
      profile = "high-quality";
      autofit = "90%";
      sub-auto = "fuzzy";
      audio-file-auto = "fuzzy";
      save-position-on-quit = true;
      vo = "gpu-next";
      hwdec = "auto";
    };
  };
}
