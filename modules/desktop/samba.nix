{
  flake.modules.nixos.desktop = {
    services.samba = {
      enable = true;
      openFirewall = true;
      settings = {
        "media" = {
          "path" = "/media";
        };
      };
    };
    preservation.preserveAt."/persist".directories = [ "/var/lib/samba" ];
  };
}
