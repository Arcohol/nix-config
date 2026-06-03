{
  flake.modules.nixos.development = {
    services.tailscale.enable = true;
  };
  flake.modules.homeManager.development =
    { pkgs, ... }:
    {
      home.packages' = with pkgs; [
        nixd
        nixfmt

        ghc
        haskell-language-server

        gcc
        {
          package = rustup;
          path = [ ".rustup" ];
        }

        python3
      ];

      home.persist = [
        ".npm" # slop
        ".cmake"
        ".codex"
      ];
    };
}
