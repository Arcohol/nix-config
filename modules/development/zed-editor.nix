{
  flake.modules.homeManager.development = { pkgs, ... }: {
    programs.zed-editor = {
      enable = true;

      extensions = [
        "catppuccin"
        "nix"
      ];

      extraPackages = with pkgs; [
        nixd
        nixfmt
      ];

      mutableUserSettings = false;
      userSettings = {
        disable_ai = true;
        project_panel.dock = "left";

        theme = "Catppuccin Mocha";

        buffer_font_family = "Sarasa Mono Slab SC";
        buffer_font_size = 16;

        ui_font_family = "Inter";
        ui_font_size = 16;

        terminal = {
          font_family = "Sarasa Mono Slab SC";
          font_size = 16;
        };

        helix_mode = true;

        cursor_shape = "block";
        cursor_blink = false;

        git.inline_blame.location = "status_bar";
        inline_code_actions = false;
        autosave.after_delay.milliseconds = 1000;

        languages = {
          Nix = {
            language_servers = [
              "nixd"
              "!nil"
            ];
          };
        };

        title_bar.show_sign_in = false;
      };
    };
  };
}
