{
  flake.modules.nixos.desktop = {
    programs.foot = {
      enable = true;
      # theme = "catppuccin-mocha";
      settings = {
        main = {
          font = "monospace:size=13";
        };
        colors = {
          alpha = 0.8;
        };
      };
    };
  };
}
