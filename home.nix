{ config, pkgs, ... }:

{
  home.username = "arcohol";
  home.homeDirectory = "/home/arcohol";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [ nixfmt-rfc-style ];

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Tiantian Li";
    userEmail = "i@arcohol.com";
    signing.key = null;
    signing.signByDefault = true;
  };

  programs.bash.enable = true;
  programs.firefox.enable = true;
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
}
