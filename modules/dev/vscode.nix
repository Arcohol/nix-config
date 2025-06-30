{
  flake.modules.homeManager.dev = {
    programs.vscode.enable = true;
    home.persist = [ ".vscode" ];
  };
}
