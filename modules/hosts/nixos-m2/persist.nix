{
  flake.modules.nixos."hosts/nixos-m2" = { lib, ... }: {
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
      # This is an ugly hack since there is no /storage in this host
      preserveAt."/storage" = lib.mkForce { };
    };
  };
}
