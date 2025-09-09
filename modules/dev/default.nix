{ inputs, ... }:
{
  flake.modules.nixos.dev = {
    nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
    nixpkgs.config.android_sdk.accept_license = true;
  };

  flake.modules.homeManager.dev =
    { pkgs, ... }:
    {
      home.packages' = with pkgs; [
        {
          package = arduino-ide;
          path = [
            ".arduino15"
            ".arduinoIDE"
            "Arduino"
          ];
        }
        arduino-cli
        {
          package = android-studio;
          path = [
            ".android"
            ".local/share/Google"
          ];
        }
        (rust-bin.stable.latest.default.override {
          extensions = [
            "rust-analyzer"
            "rust-src"
          ];
        })
        nixfmt-rfc-style
        gcc
        (python3.withPackages (
          python-pkgs: with python-pkgs; [
            requests
            pandas
            numpy
            matplotlib
          ]
        ))
        uv
        ruff
        nodejs
        nixd
      ];
    };
}
