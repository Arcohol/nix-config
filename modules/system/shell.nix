{
  flake.modules.nixos.shell = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting
      '';
    };

    programs.gnupg.agent.enable = true;

    programs.tmux.enable = true;
  };
  flake.modules.darwin.shell = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting
      '';
    };
  };
  flake.modules.homeManager.shell = {
    programs.fish.enable = true;
    programs.starship = {
      enable = true;
      presets = [ "plain-text-symbols" ];
    };
    programs.gpg.enable = true;
    home.persist.directories = [ ".local/share/fish" ];
  };
}
