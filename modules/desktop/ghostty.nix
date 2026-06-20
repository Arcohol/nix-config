{
  flake.modules.homeManager.desktop =
    { lib, pkgs, ... }:
    lib.mkIf pkgs.stdenv.isDarwin {
      programs.ghostty = {
        enable = true;
        package = pkgs.ghostty-bin;
        settings = {
          font-size = 16;
          theme = "Catppuccin Mocha";
        };
      };
    };
}
