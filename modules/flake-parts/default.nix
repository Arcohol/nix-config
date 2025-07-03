{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.treefmt-nix.flakeModule
  ];
  systems = [ "x86_64-linux" ];
  perSystem = {
    treefmt = {
      projectRootFile = "flake.nix";
      programs.nixfmt = {
        enable = true;
        strict = true;
      };
    };
  };
}
