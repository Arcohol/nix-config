{
  flake.modules.nixos."hosts/merlot" =
    { pkgs, ... }:
    let
      rgb = "${pkgs.openrgb}/bin/openrgb --nodetect --device X570-F --zone 1 --size 1 --zone 2 --size 1";
    in
    {
      services.hardware.openrgb.enable = true;
      systemd.services.openrgb.postStart = ''
        until ${rgb} --mode Static --color FF8000; do
          sleep 1
        done
      '';

      home-manager.users.arcohol.programs.noctalia.settings.hooks = {
        session_locked = "${rgb} --mode Off";
        session_unlocked = "${rgb} --mode Static --color FF8000";
      };
    };
}
