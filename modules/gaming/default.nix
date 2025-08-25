{
  flake.modules.homeManager.gaming =
    { pkgs, ... }:
    {
      home.packages' = with pkgs; [
        {
          package = bottles;
          path = [ ".local/share/bottles" ];
        }
      ];
    };
}
