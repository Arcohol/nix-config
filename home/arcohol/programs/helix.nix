{ pkgs, helix, ... }:

{
  programs.helix = {
    enable = true;
    package = helix.packages.${pkgs.system}.default;

    settings = {
      theme = "github_dark_transparent";
      editor = {
        auto-save = {
          after-delay.enable = true;
          after-delay.timeout = 1000;
        };
        lsp = {
          display-inlay-hints = true;
        };
      };
    };

    themes = {
      github_dark_transparent = {
        "inherits" = "github_dark";
        "ui.background" = { };
        "ui.cursor" = {
          fg = "fg.default";
          modifiers = [ "reversed" ];
        };
        "ui.virtual" = {
          fg = "fg.muted";
        };
      };
    };
  };
}
