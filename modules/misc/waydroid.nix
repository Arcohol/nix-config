{
  flake.modules.nixos.waydroid = { config, pkgs, ... }: {
    virtualisation.waydroid = {
      enable = true;
      package = pkgs.waydroid-nftables;
    };
    preservation.preserveAt.${config.persistence.stateRoot}.directories = [ "/var/lib/waydroid" ];
  };

  flake.modules.homeManager.waydroid = {
    home.persist.directories = [ ".local/share/waydroid" ];
  };
}
