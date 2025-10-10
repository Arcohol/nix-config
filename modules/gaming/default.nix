{
  flake.modules.homeManager.gaming =
    { pkgs, ... }:
    {
      home.packages' = with pkgs; [
        wineWowPackages.unstable
        {
          package = bottles;
          path = [ ".local/share/bottles" ];
        }
        osu-lazer
      ];
    };
}
