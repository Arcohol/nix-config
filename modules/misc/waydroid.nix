{
  flake.modules.nixos.waydroid = {
    virtualisation.waydroid.enable = true;
    preservation.preserveAt."/persist".directories = [ "/var/lib/waydroid" ];
  };

  flake.modules.homeManager.waydroid = {
    home.persist = [ ".local/share/waydroid" ];
  };
}
