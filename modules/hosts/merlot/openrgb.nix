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

      home-manager.users.arcohol.xdg.configFile."niri/lock".text = ''
        #!${pkgs.runtimeShell}
        swaylock --ready-fd 3 -i ${../../niri/wallpaper.jpg} 3> >(
          read -r && sleep 2 && niri msg action power-off-monitors && ${rgb} --mode Off
        ) && ${rgb} --mode Static --color FF8000
      '';
    };
}
