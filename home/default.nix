{ lib, ... }:

let
  nixFilesIn =
    dir:
    map (name: dir + "/${name}") (
      builtins.filter (name: lib.hasSuffix ".nix" name) (builtins.attrNames (builtins.readDir dir))
    );
in
{
  imports = (nixFilesIn ./programs);
}
