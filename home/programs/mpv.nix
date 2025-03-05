{ pkgs, ... }:

{
  programs.mpv = {
    package = (
      pkgs.mpv-unwrapped.wrapper {
        mpv = pkgs.mpv-unwrapped;
        extraMakeWrapperArgs = [
          "--set"
          "XCURSOR_SIZE"
          "24"
          "--set"
          "XCURSOR_THEME"
          "Adwaita"
        ];
      }
    );
    config = {
      profile = "high-quality";
      autofit = "90%";
      sub-auto = "fuzzy";
      audio-file-auto = "fuzzy";
      save-position-on-quit = true;
    };
  };
}
