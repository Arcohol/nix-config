{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [ pkgs.xterm ];
  };
  environment.systemPackages = with pkgs; [ gnome-tweaks ];

  systemd.tmpfiles.rules = [ "L+ /run/gdm/.config/monitors.xml - - - - ${../home/monitors.xml}" ];

  environment.gnome.excludePackages = (
    with pkgs;
    [
      gnome-tour
      gnome-text-editor
      gnome-maps
      gnome-music
      gnome-weather
      gnome-contacts
      snapshot # camera
      simple-scan # document scanner
      epiphany # web browser
      geary # email reader
      evince # document viewer
      totem # video player
      yelp # help viewer
    ]
  );
}
