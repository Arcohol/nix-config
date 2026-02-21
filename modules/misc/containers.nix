{
  flake.modules.nixos.containers =
    { pkgs, ... }:
    {
      virtualisation = {
        containers.enable = true;
        podman = {
          enable = true;
          dockerCompat = true;
        };
      };

      environment.systemPackages = with pkgs; [ docker-compose ];

      users.users.arcohol.extraGroups = [ "podman" ];
    };

  flake.modules.homeManager.containers = {
    home.persist = [ ".local/share/containers" ];
  };
}
