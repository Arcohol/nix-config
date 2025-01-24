{ username, ... }:

{
  imports = [
    ./fcitx5.nix
  ];

  programs.niri.enable = true;

  services.xserver.displayManager.gdm.enable = true;

  home-manager.users.${username} = {
    imports = [
      ./waybar.nix
      ./fuzzel.nix
    ];
  };
}
