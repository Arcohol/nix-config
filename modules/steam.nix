{ pkgs, ... }:

{
  programs.steam.enable = true;

  environment.systemPackages = [
    (pkgs.makeDesktopItem {
      name = "stream-hidpi";
      desktopName = "Steam (HiDPI)";
      exec = "env GDK_SCALE=2 steam %U";
      icon = "steam";
    })
  ];
}