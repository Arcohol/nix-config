{
  flake.modules.nixos.desktop = {
    programs.foot = {
      enable = true;
      settings = {
        main.font = "Sarasa Term SC:size=14";
        colors-dark = {
          alpha = 0.9;
          blur = true;
        };
      };
    };
  };
}
