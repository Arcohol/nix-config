{
  flake.modules.nixos.desktop = {
    programs.clash-verge = {
      enable = true;
      tunMode = true;
      autoStart = true;
      serviceMode = true;
    };
  };

  flake.modules.homeManager.desktop = {
    home.persist.directories = [ ".local/share/io.github.clash-verge-rev.clash-verge-rev" ];
  };
}
