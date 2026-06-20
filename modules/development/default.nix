{
  flake.modules.nixos.development = {
    programs.tmux.enable = true;
  };

  flake.modules.darwin.development = { };

  flake.modules.homeManager.development = { pkgs, ... }: {
    home.packages = with pkgs; [
      nixd
      nixfmt
      python3
    ];

    home.persist = [
      ".npm" # slop
      ".cmake"
      ".codex"
    ];
  };
}
