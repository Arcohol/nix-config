{
  flake.modules.nixos.desktop =
    { inputs, pkgs, ... }:
    {
      nixpkgs.overlays = [ inputs.niri.overlays.niri ];
      imports = [ inputs.niri.nixosModules.niri ];

      environment.variables = {
        NIXOS_OZONE_WL = "1";
      };

      services.gvfs.enable = true;

      programs.niri = {
        enable = true;
        package = inputs.niri-blur.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };

      programs.nautilus-open-any-terminal = {
        enable = true;
        terminal = "foot";
      };

      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet";
          };
        };
        useTextGreeter = true;
      };

      xdg.terminal-exec = {
        enable = true;
        settings = {
          niri = [ "foot.desktop" ];
        };
      };

      environment.systemPackages = with pkgs; [
        nautilus
        xwayland-satellite-unstable
        pwvucontrol
      ];
    };

  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    let
      bg = ./wallpaper.jpg;
    in
    {
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };

      programs.swaylock.enable = true;

      programs.niri.config = ''
        input {
            keyboard {
                xkb {
                    layout ""
                    model ""
                    rules ""
                    variant ""
                }
                repeat-delay 600
                repeat-rate 25
                track-layout "global"
            }
            touchpad {
                tap
                natural-scroll
            }
        }
        output "HDMI-A-1" {
            scale 2
            transform "normal"
        }
        screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"
        prefer-no-csd
        layout {
            gaps 3
            struts {
                left 0
                right 0
                top 0
                bottom 0
            }
            focus-ring { off; }
            border {
                width 3
                urgent-color "#505050"
                active-color "#f5e0dc"
                inactive-color "#505050"
            }
            default-column-width { proportion 0.500000; }
            preset-column-widths {
                proportion 0.300000
                proportion 0.500000
                proportion 0.700000
            }
            center-focused-column "never"
        }
        cursor {
            xcursor-theme "Adwaita"
            xcursor-size 24
        }
        binds {
            Alt+Print { screenshot-screen; }
            Ctrl+Alt+Delete { quit; }
            Ctrl+Print { screenshot-window; }
            Mod+1 { focus-workspace 1; }
            Mod+2 { focus-workspace 2; }
            Mod+3 { focus-workspace 3; }
            Mod+4 { focus-workspace 4; }
            Mod+5 { focus-workspace 5; }
            Mod+6 { focus-workspace 6; }
            Mod+7 { focus-workspace 7; }
            Mod+8 { focus-workspace 8; }
            Mod+9 { focus-workspace 9; }
            Mod+A { set-column-width "30%"; }
            Mod+BracketLeft { consume-or-expel-window-left; }
            Mod+BracketRight { consume-or-expel-window-right; }
            Mod+C { center-column; }
            Mod+Comma { consume-window-into-column; }
            Mod+Ctrl+1 { move-column-to-workspace 1; }
            Mod+Ctrl+2 { move-column-to-workspace 2; }
            Mod+Ctrl+3 { move-column-to-workspace 3; }
            Mod+Ctrl+4 { move-column-to-workspace 4; }
            Mod+Ctrl+5 { move-column-to-workspace 5; }
            Mod+Ctrl+6 { move-column-to-workspace 6; }
            Mod+Ctrl+7 { move-column-to-workspace 7; }
            Mod+Ctrl+8 { move-column-to-workspace 8; }
            Mod+Ctrl+9 { move-column-to-workspace 9; }
            Mod+Ctrl+C { center-visible-columns; }
            Mod+Ctrl+Down { move-window-down; }
            Mod+Ctrl+End { move-column-to-last; }
            Mod+Ctrl+F { expand-column-to-available-width; }
            Mod+Ctrl+H { move-column-left; }
            Mod+Ctrl+Home { move-column-to-first; }
            Mod+Ctrl+I { move-column-to-workspace-up; }
            Mod+Ctrl+J { move-window-down; }
            Mod+Ctrl+K { move-window-up; }
            Mod+Ctrl+L { move-column-right; }
            Mod+Ctrl+Left { move-column-left; }
            "Mod+Ctrl+Page_Down" { move-column-to-workspace-down; }
            "Mod+Ctrl+Page_Up" { move-column-to-workspace-up; }
            Mod+Ctrl+R { reset-window-height; }
            Mod+Ctrl+Right { move-column-right; }
            Mod+Ctrl+Shift+F { toggle-windowed-fullscreen; }
            Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
            Mod+Ctrl+Shift+WheelScrollUp { move-column-left; }
            Mod+Ctrl+U { move-column-to-workspace-down; }
            Mod+Ctrl+Up { move-window-up; }
            Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
            Mod+Ctrl+WheelScrollLeft { move-column-left; }
            Mod+Ctrl+WheelScrollRight { move-column-right; }
            Mod+Ctrl+WheelScrollUp cooldown-ms=150 { move-column-to-workspace-up; }
            Mod+D hotkey-overlay-title="Run an Application: fuzzel" { spawn "fuzzel"; }
            Mod+Down { focus-window-down; }
            Mod+End { focus-column-last; }
            Mod+Equal { set-column-width "+10%"; }
            Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
            Mod+F { maximize-column; }
            Mod+H { focus-column-left; }
            Mod+Home { focus-column-first; }
            Mod+I { focus-workspace-up; }
            Mod+J { focus-window-down; }
            Mod+K { focus-window-up; }
            Mod+L { focus-column-right; }
            Mod+Left { focus-column-left; }
            Mod+Minus { set-column-width "-10%"; }
            Mod+O repeat=false { toggle-overview; }
            "Mod+Page_Down" { focus-workspace-down; }
            "Mod+Page_Up" { focus-workspace-up; }
            Mod+Period { expel-window-from-column; }
            Mod+Q repeat=false { close-window; }
            Mod+R { switch-preset-column-width; }
            Mod+Right { focus-column-right; }
            Mod+S { set-column-width "70%"; }
            Mod+Shift+Ctrl+Down { move-column-to-monitor-down; }
            Mod+Shift+Ctrl+H { move-column-to-monitor-left; }
            Mod+Shift+Ctrl+J { move-column-to-monitor-down; }
            Mod+Shift+Ctrl+K { move-column-to-monitor-up; }
            Mod+Shift+Ctrl+L { move-column-to-monitor-right; }
            Mod+Shift+Ctrl+Left { move-column-to-monitor-left; }
            Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
            Mod+Shift+Ctrl+Up { move-column-to-monitor-up; }
            Mod+Shift+Down { focus-monitor-down; }
            Mod+Shift+E { quit; }
            Mod+Shift+Equal { set-window-height "+10%"; }
            Mod+Shift+F { fullscreen-window; }
            Mod+Shift+H { focus-monitor-left; }
            Mod+Shift+I { move-workspace-up; }
            Mod+Shift+J { focus-monitor-down; }
            Mod+Shift+K { focus-monitor-up; }
            Mod+Shift+L { focus-monitor-right; }
            Mod+Shift+Left { focus-monitor-left; }
            Mod+Shift+Minus { set-window-height "-10%"; }
            Mod+Shift+P { power-off-monitors; }
            "Mod+Shift+Page_Down" { move-workspace-down; }
            "Mod+Shift+Page_Up" { move-workspace-up; }
            Mod+Shift+R { switch-preset-window-height; }
            Mod+Shift+Right { focus-monitor-right; }
            Mod+Shift+Slash { show-hotkey-overlay; }
            Mod+Shift+U { move-workspace-down; }
            Mod+Shift+Up { focus-monitor-up; }
            Mod+Shift+V { switch-focus-between-floating-and-tiling; }
            Mod+Shift+WheelScrollDown { focus-column-right; }
            Mod+Shift+WheelScrollUp { focus-column-left; }
            Mod+T hotkey-overlay-title="Open a Terminal: foot" { spawn "foot"; }
            Mod+U { focus-workspace-down; }
            Mod+Up { focus-window-up; }
            Mod+V { toggle-window-floating; }
            Mod+W { toggle-column-tabbed-display; }
            Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
            Mod+WheelScrollLeft { focus-column-left; }
            Mod+WheelScrollRight { focus-column-right; }
            Mod+WheelScrollUp cooldown-ms=150 { focus-workspace-up; }
            Mod+Z { set-column-width "50%"; }
            Print { screenshot; }
            Super+Alt+L hotkey-overlay-title="Lock and Close the Screen" { spawn "sh" "-c" "swaylock -f -i ${bg} && sleep 2 && niri msg action power-off-monitors"; }
            XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
            XF86AudioMicMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
            XF86AudioMute allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
            XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"; }
            XF86MonBrightnessDown allow-when-locked=true { spawn "${pkgs.brightnessctl}/bin/brightnessctl" "--class=backlight" "set" "10%-"; }
            XF86MonBrightnessUp allow-when-locked=true { spawn "${pkgs.brightnessctl}/bin/brightnessctl" "--class=backlight" "set" "+10%"; }
        }
        spawn-at-startup "${pkgs.swaybg}/bin/swaybg" "--mode" "fill" "--image" "${bg}"
        window-rule { clip-to-geometry true; }
        window-rule {
            match app-id="^foot$"
            background-effect {
                blur true
            }
        }
        window-rule {
            match app-id="^mpv$"
            open-maximized true
        }
        window-rule {
            match app-id="^code$"
            open-maximized true
        }
        window-rule {
            match app-id="^firefox$"
            default-column-width { proportion 0.700000; }
        }
        window-rule {
            match app-id="^org.telegram.desktop$"
            default-column-width { proportion 0.300000; }
        }
        window-rule {
            match app-id="^firefox$" title="^Picture-in-Picture$"
            default-column-width { proportion 0.500000; }
            default-window-height { proportion 0.500000; }
            open-floating true
        }
        window-rule {
            match app-id="^org.telegram.desktop$" title="^Media viewer$"
            default-column-width { proportion 0.700000; }
            default-window-height { proportion 0.700000; }
            open-fullscreen false
            open-floating true
        }
      '';
    };
}
