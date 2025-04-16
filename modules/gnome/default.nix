{ pkgs, username, ... }:

{
  # Home Manager configuration
  home-manager.users.${username} = {
    imports = [
      ./dconf.nix
      {
        xdg.configFile."paperwm/user.css" = {
          text = ''
            .paperwm-selection { background-color: rgba(0, 0, 0, 0); }
          '';
        };
      }
    ];
  };

  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ rime ];
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [ pkgs.xterm ];
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-terminal
    gnomeExtensions.appindicator
    gnomeExtensions.system-monitor
    gnomeExtensions.paperwm
    gnomeExtensions.dash-to-dock
  ];

  environment.gnome.excludePackages = (
    with pkgs;
    [
      gnome-console
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
