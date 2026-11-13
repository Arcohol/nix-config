{
  flake.modules.nixos."hosts/nixos-m2" = {
    preservation = {
      preserveAt."/persist" = {
        files = [
          {
            file = "/etc/ssh/ssh_host_rsa_key";
            how = "symlink";
          }
          {
            file = "/etc/ssh/ssh_host_ed25519_key";
            how = "symlink";
          }
        ];
        users.arcohol.directories = [
          "Desktop"
          "Downloads"
          "Documents"
          "Music"
          "Pictures"
          "Projects"
          "Videos"
        ];
      };
    };
  };
}
