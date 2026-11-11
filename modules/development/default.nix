{
  flake.modules.nixos.development = { };

  flake.modules.darwin.development = { };

  flake.modules.homeManager.development = { pkgs, ... }: {
    home.packages = with pkgs; [ chatgpt ];
    home.persist.directories = [
      ".cmake"
      ".codex"
    ];
  };
}
