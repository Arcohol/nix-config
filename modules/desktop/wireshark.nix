{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      programs.wireshark = {
        enable = true;
        package = pkgs.wireshark;
      };
      users.users.arcohol.extraGroups = [ "wireshark" ];
    };
}
