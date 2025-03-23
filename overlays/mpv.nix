final: prev: {
  mpv = prev.mpv.override {
    extraMakeWrapperArgs = [
      "--set"
      "XCURSOR_SIZE"
      "24"
      "--set"
      "XCURSOR_THEME"
      "Adwaita"
    ];
  };
}
