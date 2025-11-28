{
  flake.modules.nixos.development = { };
  flake.modules.homeManager.development =
    { pkgs, ... }:
    {
      home.packages' = with pkgs; [
        nixd
        nixfmt

        ghc
        haskell-language-server
      ];
    };
}
