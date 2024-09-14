{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [ pkgs.xterm ];
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-terminal
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

  nixpkgs.overlays = [
    # GNOME 46: triple-buffering-v4-46
    (final: prev: {
      mutter = prev.mutter.overrideAttrs (old: {
        src = pkgs.fetchFromGitLab {
          domain = "gitlab.gnome.org";
          owner = "vanvugt";
          repo = "mutter";
          rev = "triple-buffering-v4-46";
          hash = "sha256-C2VfW3ThPEZ37YkX7ejlyumLnWa9oij333d5c4yfZxc=";
        };
      });
    })
  ];
}
