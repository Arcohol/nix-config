{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.treefmt-nix.flakeModule
  ];
  systems = [ "x86_64-linux" ];
  perSystem =
    { pkgs, ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";
        programs.nixfmt = {
          enable = true;
          strict = true;
        };
      };
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nixd
          nixfmt
        ];
      };
    };
}
