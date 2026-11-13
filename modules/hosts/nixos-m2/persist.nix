{
  flake.modules.nixos."hosts/nixos-m2" = {
    persistence = {
      stateRoot = "/persist";
      dataRoot = "/persist";
    };
  };
}
