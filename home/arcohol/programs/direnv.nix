{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  home.persist = [ ".local/share/direnv" ];
}
