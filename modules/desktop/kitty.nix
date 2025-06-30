{
  flake.modules.homeManager.desktop = {
    programs.kitty = {
      enable = true;
      settings = {
        background_opacity = 0.8;
        font_size = 12;
        wayland_enable_ime = "no";
        enabled_layouts = "tall:bias=60;full_size=1;mirrored=false";
      };
      shellIntegration.mode = "no-cursor";
    };
  };
}
