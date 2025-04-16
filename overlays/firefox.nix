final: prev: {
  firefox = prev.firefox.overrideAttrs (old: {
    makeWrapperArgs = old.makeWrapperArgs ++ [
      "--set"
      "MOZ_DISABLE_RDD_SANDBOX"
      "1"
    ];
  });
}
