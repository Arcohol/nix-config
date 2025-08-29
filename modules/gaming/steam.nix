{
  flake.modules.nixos.gaming =
    { pkgs, ... }:
    {
      programs.steam.enable = true;
      environment.systemPackages = with pkgs; [
        mangohud
        gamemode
      ];
    };

  flake.modules.homeManager.gaming = {
    xdg.desktopEntries = {
      steam = {
        name = "Steam";
        exec = "env GDK_SCALE=2 steam %U";
        icon = "steam";
      };
    };
    home.persist = [
      ".local/share/Steam"
      ".steam"
      ".local/share/vulkan"
    ];
  };
}
