{
  flake.modules.homeManager.desktop = {
    programs.mpv = {
      enable = true;
      config = {
        profile = "high-quality";
        sub-auto = "fuzzy";
        audio-file-auto = "fuzzy";
        save-position-on-quit = true;
        vo = "gpu-next";
        hwdec = "auto";
        autocreate-playlist = "filter";
        directory-filter-types = "video,audio";
      };
    };
    home.persist = [ ".local/state/mpv" ];
  };
}
