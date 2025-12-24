{
  flake.modules.nixos.liquidctl =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.liquidctl ];
      services.udev.packages = [ pkgs.liquidctl ];

      systemd.services.liquidctl = {
        wantedBy = [ "multi-user.target" ];
        after = [ "multi-user.target" ];

        path = [ pkgs.liquidctl ];

        serviceConfig = {
          Type = "oneshot";
          ExecStart = pkgs.writeShellScript "liquidctl-startup" ''
            liquidctl initialize all
            liquidctl --serial 3459337D3239 set lcd screen brightness 25
            liquidctl --serial 3459337D3239 set lcd screen static ${./sticker.webp}
          '';
        };
      };
    };
}
