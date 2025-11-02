{
  flake.modules.nixos.waydroid =
    { pkgs, ... }:
    {
      virtualisation.waydroid = {
        enable = true;
        package = pkgs.waydroid-nftables;
      };
      preservation.preserveAt."/persist".directories = [ "/var/lib/waydroid" ];
    };

  flake.modules.homeManager.waydroid = {
    home.persist = [ ".local/share/waydroid" ];
  };
}
