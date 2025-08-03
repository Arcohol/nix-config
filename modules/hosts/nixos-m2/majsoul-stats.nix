{ inputs, ... }:
{
  flake.modules.nixos."hosts/nixos-m2" =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [ inputs.majsoul-stats.overlays.default ];

      users.users.majsoul-stats = {
        isSystemUser = true;
        group = "majsoul-stats";
      };
      users.groups.majsoul-stats = { };

      systemd.services.majsoul-stats = {
        serviceConfig = {
          User = "majsoul-stats";
          Group = "majsoul-stats";
          ExecStart = "${pkgs.majsoul-stats}/bin/majsoul-stats";
          Restart = "on-failure";
        };
        wantedBy = [ "multi-user.target" ];
        after = [ "network-online.target" ];
        requires = [ "network-online.target" ];
      };
    };
}
