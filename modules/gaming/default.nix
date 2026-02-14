{
  flake.modules.homeManager.gaming =
    { pkgs, ... }:
    {
      home.packages' = with pkgs; [
        wineWow64Packages.unstable
        {
          package = bottles;
          path = [ ".local/share/bottles" ];
        }
        {
          package = prismlauncher;
          path = [ ".local/share/PrismLauncher" ];
        }
      ];
    };
}
