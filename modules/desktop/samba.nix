{
  flake.modules.nixos.desktop = { config, ... }: {
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
    preservation.preserveAt.${config.persistence.stateRoot}.directories = [ "/var/lib/samba" ];
  };
}
