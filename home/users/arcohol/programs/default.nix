{
  imports = [
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./kitty.nix
    ./mpv.nix
    ./zed-editor.nix
  ];

  programs.bash.enable = true;
  programs.direnv.enable = true;
  programs.fish.enable = true;
  programs.firefox.enable = true;
  programs.git.enable = true;
  programs.gpg.enable = true;
  programs.helix.enable = true;
  programs.kitty.enable = true;
  programs.mpv.enable = true;
  programs.vscode.enable = true;
  programs.yt-dlp.enable = true;
}
