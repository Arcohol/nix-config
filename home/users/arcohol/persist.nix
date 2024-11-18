{
  directories = [
    "Desktop"
    "Documents"
    "Downloads"
    "Music"
    "Pictures"
    "Public"
    "Templates"
    "Videos"

    "projects" # personal stuff

    ".config" # dotfiles
    ".cmake" # cmake
    ".mozilla" # firefox
    ".vscode" # vscode
    ".rustup" # rustup
    ".cache/spotify" # spotify
    ".local/share/TelegramDesktop" # telegram
    ".local/share/direnv" # direnv
    ".local/share/zed" # zed editor
    ".local/state/wireplumber" # audio
    ".local/state/mpv" # mpv playback history
    {
      directory = ".gnupg";
      mode = "0700";
    }
    {
      directory = ".ssh";
      mode = "0700";
    }
    {
      directory = ".local/share/keyrings";
      mode = "0700";
    }
  ];
}
