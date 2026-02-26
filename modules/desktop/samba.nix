{
  flake.modules.nixos.desktop = {
    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        "videos" = {
          "path" = "/home/arcohol/Videos";
        };
        "documents" = {
          "path" = "/home/arcohol/Documents";
        };
      };
    };
    preservation.preserveAt."/persist".directories = [ "/var/lib/samba" ];
  };
}
