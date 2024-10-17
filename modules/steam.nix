{
  pkgs,
  username,
  persistPath,
  ...
}:

{
  programs.steam.enable = true;

  environment.persistence."${persistPath}".users.${username}.directories = [
    ".local/share/Steam"
    ".steam"
  ];

  environment.systemPackages = with pkgs; [
    mangohud
  ];

  home-manager.users.${username} = {
    xdg.desktopEntries = {
      steam = {
        name = "Steam";
        exec = "env GDK_SCALE=2 steam %U";
        icon = "steam";
      };
    };
  };
}
