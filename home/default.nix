{
  inputs,
  username,
  persistPath,
  ...
}:

{
  # Home Manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    helix = inputs.helix;
  };
  home-manager.users.${username} = {
    imports = [ ./${username} ];

    home.username = "${username}";
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "24.05";

    programs.home-manager.enable = true;
  };

  # Impermanence
  environment.persistence.${persistPath}.users.${username} = import ./${username}/persist.nix;
}
