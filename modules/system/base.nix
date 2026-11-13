{
  flake.modules.nixos.base = { config, ... }: {
    preservation.preserveAt.${config.persistence.stateRoot} = {
      directories = [
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
        "/var/log"
        "/var/lib/systemd"
      ];
      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];
      users.root.directories = [ ".cache/nix" ];
    };
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
