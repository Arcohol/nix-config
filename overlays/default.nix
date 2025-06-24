{ inputs, ... }:

let
  rust-overlay = inputs.rust-overlay;
  niri = inputs.niri;
in
{
  nixpkgs.overlays =
    [
      rust-overlay.overlays.default
      niri.overlays.niri
    ]
    ++ [
      (import ./mpv.nix)
      # (import ./firefox.nix)
    ];
}
