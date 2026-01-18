{
  flake.modules.nixos.desktop = {
    programs.foot = {
      enable = true;
      settings = {
        main.font = "monospace:size=14";
        colors.alpha = 0.9;
      };
    };
  };
}
