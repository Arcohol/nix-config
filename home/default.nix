{ username, ... }:

{
  imports = [
    ./dconf.nix
    ./fonts.nix
  ];

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
