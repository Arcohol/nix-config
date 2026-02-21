{
  flake.modules.nixos.containers = {
    virtualisation = {
      containers.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
      };
    };

    users.users.arcohol.extraGroups = [ "podman" ];
  };
}
