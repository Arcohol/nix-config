{
  flake.modules.nixos."hosts/merlot" = {
    persistence = {
      stateRoot = "/persist";
      dataRoot = "/storage";
    };
  };
}
