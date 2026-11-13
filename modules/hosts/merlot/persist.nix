{
  flake.modules.nixos."hosts/merlot" = {
    preservation = {
      preserveAt."/storage" = {
        commonMountOptions = [ "x-gvfs-hide" ];

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
