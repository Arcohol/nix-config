{
  flake.modules.homeManager.desktop =
    { lib, pkgs, ... }:
    lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      programs.ghostty = {
        enable = true;
        package = pkgs.ghostty-bin;
        settings = {
          font-size = 18;
          theme = "Catppuccin Mocha";
          background-opacity = 0.9;
          background-blur = true;
          font-family = "Sarasa Mono SC";
          shell-integration-features = "no-cursor";
          cursor-style = "block";
          cursor-style-blink = false;
        };
      };
    };
}
