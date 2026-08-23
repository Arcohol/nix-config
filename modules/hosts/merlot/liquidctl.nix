{
  flake.modules.nixos."hosts/merlot" = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.liquidctl ];
    services.udev.packages = [ pkgs.liquidctl ];

    systemd.services.liquidctl-leds-off = {
      description = "Turn off liquidctl-controlled LEDs";
      wantedBy = [ "multi-user.target" ];
      after = [ "systemd-udev-trigger.service" ];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };

      script = ''
        ${pkgs.liquidctl}/bin/liquidctl initialize all
        ${pkgs.liquidctl}/bin/liquidctl --vendor 0b05 --product 18f3 set sync color off
        ${pkgs.liquidctl}/bin/liquidctl --vendor 1e71 --product 200d set sync color off
        ${pkgs.liquidctl}/bin/liquidctl --vendor 1e71 --product 3008 set external color off
      '';
    };
  };
}
