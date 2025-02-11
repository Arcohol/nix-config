{ username, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${username} = {
    imports = [ ./home/users/${username} ];

    home.username = "${username}";
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "24.05";

    programs.home-manager.enable = true;
  };
}
