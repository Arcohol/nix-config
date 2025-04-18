{ inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
    (import ./mpv.nix)
    # (import ./firefox.nix)
  ];
}
