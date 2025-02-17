{ lib, ... }:

let
  inherit (lib) hasSuffix;
  inherit (builtins) filter attrNames readDir;

  nixFilesIn =
    dir: map (name: dir + "/${name}") (filter (name: hasSuffix ".nix" name) (attrNames (readDir dir)));
in
{
  imports = (nixFilesIn ./programs);
}
