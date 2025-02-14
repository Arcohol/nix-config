{
  programs.zed-editor = {
    extensions = [
      "github-theme"
      "nix"
    ];
    userSettings = {
      theme = "Github Dark";
      vim_mode = true;
      cursor_blink = false;
      terminal = {
        env = {
          TERM = "xterm-256color";
        };
      };
      git = {
        inline_blame = {
          enabled = false;
        };
      };
      autosave = {
        after_delay = {
          milliseconds = 1000;
        };
      };
    };
  };
}
