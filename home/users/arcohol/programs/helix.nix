{ pkgs, helix, ... }:

{
  programs.helix = {
    package = helix.packages.${pkgs.system}.default;

    languages = {
      language =
        map
          (name: {
            name = name;
            auto-format = false;
          })
          [
            "rust"
            "python"
          ];
    };

    settings = {
      theme = "github_dark_transparent";
      editor = {
        auto-save = {
          after-delay.enable = true;
          after-delay.timeout = 1000;
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
      };
    };
  };
}
