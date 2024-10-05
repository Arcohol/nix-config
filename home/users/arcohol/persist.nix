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
    ".mozilla" # firefox
    ".vscode" # vscode
    ".rustup" # rustup
    ".cache/spotify" # spotify
    ".local/share/TelegramDesktop" # telegram
    ".local/share/direnv" # direnv
    ".local/state/wireplumber" # audio
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
