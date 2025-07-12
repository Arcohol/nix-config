{
  flake.modules.homeManager.dev =
    { pkgs, ... }:
    {
      home.packages' = with pkgs; [
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
          ]
        ))
        uv
        ruff
        nodejs
        nixd
      ];
    };
}
