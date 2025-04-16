{
  nixpkgs.overlays = [
    (import ./mpv.nix)
    (import ./firefox.nix)
  ];
}
