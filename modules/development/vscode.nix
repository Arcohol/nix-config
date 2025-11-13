{
  flake.modules.homeManager.development = {
    programs.vscode.enable = true;
    home.persist = [ ".vscode" ];
  };
}
