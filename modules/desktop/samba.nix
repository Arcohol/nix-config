{
  flake.modules.nixos.desktop = {
    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        "videos" = {
          "path" = "/home/arcohol/Videos";
        };
      };
    };
    preservation.preserveAt."/persist".directories = [ "/var/lib/samba" ];
  };
}
