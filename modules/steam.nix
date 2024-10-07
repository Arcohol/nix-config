{ pkgs, ... }:

{
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud # somehow it solves the issue with tiny cursor in games, wtf???
    (makeDesktopItem {
      name = "stream-hidpi";
      desktopName = "Steam (HiDPI)";
      exec = "env GDK_SCALE=2 steam %U";
      icon = "steam";
    })
  ];
}
