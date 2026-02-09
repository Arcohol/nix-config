{
  flake.modules.homeManager.development =
    { pkgs, ... }:
    {
      programs.vscode = {
        enable = true;
        package = pkgs.vscode.override { commandLineArgs = "--password-store=\"gnome-libsecret\""; };
      };
      home.persist = [ ".vscode" ];
    };
}
