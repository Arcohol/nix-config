{ pkgs, ... }:

let
  monitorsConfig = pkgs.writeText "monitors.xml" ''
    <monitors version="2">
      <configuration>
        <logicalmonitor>
          <x>0</x>
          <y>0</y>
          <scale>2</scale>
          <primary>yes</primary>
          <monitor>
            <monitorspec>
              <connector>DP-1</connector>
              <vendor>KOS</vendor>
              <product>KOIOS K2721UD</product>
              <serial>0000000000000</serial>
            </monitorspec>
            <mode>
              <width>3840</width>
              <height>2160</height>
              <rate>59.997</rate>
            </mode>
          </monitor>
        </logicalmonitor>
        <disabled>
          <monitorspec>
            <connector>eDP-1</connector>
            <vendor>CSO</vendor>
            <product>0x076d</product>
            <serial>0x00000000</serial>
          </monitorspec>
        </disabled>
      </configuration>
    </monitors>
  '';
in
{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [ pkgs.xterm ];
  };
  environment.systemPackages = with pkgs; [ gnome-tweaks ];

  systemd.tmpfiles.rules = [ "L+ /run/gdm/.config/monitors.xml - - - - ${monitorsConfig}" ];

  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-tour
      gnome-text-editor
      snapshot # camera
      simple-scan # document scanner
      epiphany # web browser
      geary # email reader
      evince # document viewer
      totem # video player
      yelp # help viewer
    ])
    ++ (with pkgs.gnome; [
      gnome-maps
      gnome-music
      gnome-weather
      gnome-contacts
    ]);
}
