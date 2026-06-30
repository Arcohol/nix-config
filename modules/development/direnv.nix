{
  flake.modules.homeManager.development = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    home.persist.directories = [ ".local/share/direnv" ];
  };
}
