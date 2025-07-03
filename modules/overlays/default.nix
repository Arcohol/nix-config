{ inputs, ... }:
{
  flake.modules.nixos.overlays = {
    nixpkgs.overlays = [
      inputs.rust-overlay.overlays.default
      inputs.niri.overlays.niri
    ];
  };
}
