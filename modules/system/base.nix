{
  flake.modules.nixos.base = {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    nixpkgs.config.allowUnfree = true;

    time.timeZone = "Asia/Shanghai";
    i18n.defaultLocale = "en_US.UTF-8";
  };
  flake.modules.darwin.base = {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    nixpkgs.config.allowUnfree = true;
  };
}
