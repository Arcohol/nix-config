{ lib, username, ... }:

let
  inherit (lib) hasSuffix;
  inherit (builtins) filter attrNames readDir;

  nixFilesIn =
    dir: map (name: dir + "/${name}") (filter (name: hasSuffix ".nix" name) (attrNames (readDir dir)));
in
{
  # Home Manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${username} = {
    imports = (nixFilesIn ./programs) ++ [ ./users/${username} ];

    home.username = "${username}";
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "24.05";

    programs.home-manager.enable = true;
  };

  # Impermanence
  environment.persistence."/persist".users.${username} = import ./users/${username}/persist.nix;
}
