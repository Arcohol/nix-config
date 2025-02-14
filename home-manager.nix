{ username, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${username} = {
    imports = [
      ./users/${username}
      ./home
    ];

    home.username = "${username}";
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "24.05";

    programs.home-manager.enable = true;
  };
}
