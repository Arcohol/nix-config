{ inputs, ... }:
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [ inputs.niri.overlays.niri ];
      imports = [ inputs.niri.nixosModules.niri ];

      environment.variables = {
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORMTHEME = "xdgdesktopportal";
      };

      security.pam.services.swaylock = { };

      services.displayManager.gdm.enable = true;
      services.gvfs.enable = true;

      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };

      environment.systemPackages = with pkgs; [
        xwayland-satellite-unstable
        adwaita-icon-theme
        nemo-with-extensions
        pwvucontrol
      ];
    };

  flake.modules.homeManager.desktop =
    { pkgs, config, ... }:
    let
      bg = ./wallpaper.jpg;
    in
    {
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
        "org/cinnamon/desktop/applications/terminal" = {
          exec = "kitty";
        };
      };

      xdg.portal = {
        enable = true;
        config.niri = {
          default = [
            "gnome"
            "gtk"
          ];
          "org.freedesktop.impl.portal.Access" = "gtk";
          "org.freedesktop.impl.portal.Notification" = "gtk";
          "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
          "org.freedesktop.impl.portal.FileChooser" = "gtk";
        };
        extraPortals = [
          pkgs.xdg-desktop-portal-gnome
          pkgs.xdg-desktop-portal-gtk
        ];
      };

      programs.swaylock.enable = true;

      programs.niri.settings = {
        # Layout settings
        layout = {
          gaps = 8;
          center-focused-column = "never";

          preset-column-widths = [
            { proportion = 0.3; }
            { proportion = 0.5; }
            { proportion = 0.7; }
          ];

          default-column-width.proportion = 0.5;

          focus-ring = {
            enable = true;
            width = 3;
            active.color = "#7fc8ff";
            inactive.color = "#505050";
          };
        };

        # Spawn settings
        spawn-at-startup = [
          {
            command = [
              "${pkgs.swaybg}/bin/swaybg"
              "--mode"
              "fill"
              "--image"
              "${bg}"
            ];
          }
        ];

        # Output configuration
        outputs."HDMI-A-1".scale = 2;

        # Cursor settings
        cursor = {
          theme = "Adwaita";
          size = 24;
        };

        # Prefer no client-side decorations
        prefer-no-csd = true;

        # Screenshot path
        screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

        # Window rules
        window-rules = [
          {
            matches = [ { app-id = "^firefox$"; } ];
            default-column-width.proportion = 0.7;
          }

          {
            matches = [ { app-id = "^org\.telegram\.desktop$"; } ];
            default-column-width.proportion = 0.3;
          }

          # {
          #   matches = [ { app-id = "^code$"; } ];
          #   opacity = 0.9;
          #   draw-border-with-background = false;
          # }

          {
            matches = [
              {
                app-id = "^firefox$";
                title = "^Picture-in-Picture$";
              }
            ];
            open-floating = true;
            default-window-height.proportion = 0.5;
            default-column-width.proportion = 0.5;
          }

          {
            matches = [
              {
                app-id = "^org\.telegram\.desktop$";
                title = "^Media viewer$";
              }
            ];
            open-fullscreen = false;
            open-floating = true;
            default-column-width.proportion = 0.7;
            default-window-height.proportion = 0.7;
          }

          {
            matches = [ { is-floating = true; } ];
            focus-ring.enable = false;
          }
        ];

        # Bindings
        binds = with config.lib.niri.actions; {
          # Help
          "Mod+Shift+Slash".action = show-hotkey-overlay;

          # Applications
          "Mod+T" = {
            action = spawn "foot";
            hotkey-overlay.title = "Open a Terminal: foot";
          };
          "Mod+D" = {
            action = spawn "fuzzel";
            hotkey-overlay.title = "Run an Application: fuzzel";
          };
          "Super+Alt+L" = {
            action = spawn "sh" "-c" "swaylock -f -i ${bg} && sleep 2 && niri msg action power-off-monitors";
            hotkey-overlay.title = "Lock and Close the Screen";
          };

          # Audio controls
          "XF86AudioRaiseVolume" = {
            action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
            allow-when-locked = true;
          };
          "XF86AudioLowerVolume" = {
            action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
            allow-when-locked = true;
          };
          "XF86AudioMute" = {
            action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
            allow-when-locked = true;
          };
          "XF86AudioMicMute" = {
            action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
            allow-when-locked = true;
          };

          # Brightness controls
          "XF86MonBrightnessUp" = {
            action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "--class=backlight" "set" "+10%";
            allow-when-locked = true;
          };
          "XF86MonBrightnessDown" = {
            action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "--class=backlight" "set" "10%-";
            allow-when-locked = true;
          };

          # Window management
          "Mod+O" = {
            action = toggle-overview;
            repeat = false;
          };
          "Mod+Q" = {
            action = close-window;
            repeat = false;
          };

          # Focus movement
          "Mod+Left".action = focus-column-left;
          "Mod+Down".action = focus-window-down;
          "Mod+Up".action = focus-window-up;
          "Mod+Right".action = focus-column-right;
          "Mod+H".action = focus-column-left;
          "Mod+J".action = focus-window-down;
          "Mod+K".action = focus-window-up;
          "Mod+L".action = focus-column-right;

          # Window/column moving
          "Mod+Ctrl+Left".action = move-column-left;
          "Mod+Ctrl+Down".action = move-window-down;
          "Mod+Ctrl+Up".action = move-window-up;
          "Mod+Ctrl+Right".action = move-column-right;
          "Mod+Ctrl+H".action = move-column-left;
          "Mod+Ctrl+J".action = move-window-down;
          "Mod+Ctrl+K".action = move-window-up;
          "Mod+Ctrl+L".action = move-column-right;

          # Column positioning
          "Mod+Home".action = focus-column-first;
          "Mod+End".action = focus-column-last;
          "Mod+Ctrl+Home".action = move-column-to-first;
          "Mod+Ctrl+End".action = move-column-to-last;

          # Monitor focus
          "Mod+Shift+Left".action = focus-monitor-left;
          "Mod+Shift+Down".action = focus-monitor-down;
          "Mod+Shift+Up".action = focus-monitor-up;
          "Mod+Shift+Right".action = focus-monitor-right;
          "Mod+Shift+H".action = focus-monitor-left;
          "Mod+Shift+J".action = focus-monitor-down;
          "Mod+Shift+K".action = focus-monitor-up;
          "Mod+Shift+L".action = focus-monitor-right;

          # Monitor movement
          "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
          "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
          "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
          "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
          "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
          "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

          # Workspace navigation
          "Mod+Page_Down".action = focus-workspace-down;
          "Mod+Page_Up".action = focus-workspace-up;
          "Mod+U".action = focus-workspace-down;
          "Mod+I".action = focus-workspace-up;
          "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
          "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
          "Mod+Ctrl+U".action = move-column-to-workspace-down;
          "Mod+Ctrl+I".action = move-column-to-workspace-up;

          # Workspace movement
          "Mod+Shift+Page_Down".action = move-workspace-down;
          "Mod+Shift+Page_Up".action = move-workspace-up;
          "Mod+Shift+U".action = move-workspace-down;
          "Mod+Shift+I".action = move-workspace-up;

          # Mouse wheel workspace navigation
          "Mod+WheelScrollDown" = {
            action = focus-workspace-down;
            cooldown-ms = 150;
          };
          "Mod+WheelScrollUp" = {
            action = focus-workspace-up;
            cooldown-ms = 150;
          };
          "Mod+Ctrl+WheelScrollDown" = {
            action = move-column-to-workspace-down;
            cooldown-ms = 150;
          };
          "Mod+Ctrl+WheelScrollUp" = {
            action = move-column-to-workspace-up;
            cooldown-ms = 150;
          };

          # Mouse wheel column navigation
          "Mod+WheelScrollRight".action = focus-column-right;
          "Mod+WheelScrollLeft".action = focus-column-left;
          "Mod+Ctrl+WheelScrollRight".action = move-column-right;
          "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

          # Alternative mouse wheel column navigation
          "Mod+Shift+WheelScrollDown".action = focus-column-right;
          "Mod+Shift+WheelScrollUp".action = focus-column-left;
          "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
          "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

          # Numbered workspace navigation
          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;
          "Mod+6".action = focus-workspace 6;
          "Mod+7".action = focus-workspace 7;
          "Mod+8".action = focus-workspace 8;
          "Mod+9".action = focus-workspace 9;
          "Mod+Ctrl+1".action.move-column-to-workspace = 1;
          "Mod+Ctrl+2".action.move-column-to-workspace = 2;
          "Mod+Ctrl+3".action.move-column-to-workspace = 3;
          "Mod+Ctrl+4".action.move-column-to-workspace = 4;
          "Mod+Ctrl+5".action.move-column-to-workspace = 5;
          "Mod+Ctrl+6".action.move-column-to-workspace = 6;
          "Mod+Ctrl+7".action.move-column-to-workspace = 7;
          "Mod+Ctrl+8".action.move-column-to-workspace = 8;
          "Mod+Ctrl+9".action.move-column-to-workspace = 9;

          # Window consumption/expulsion
          "Mod+BracketLeft".action = consume-or-expel-window-left;
          "Mod+BracketRight".action = consume-or-expel-window-right;
          "Mod+Comma".action = consume-window-into-column;
          "Mod+Period".action = expel-window-from-column;

          # Window/column sizing
          "Mod+R".action = switch-preset-column-width;
          "Mod+Shift+R".action = switch-preset-window-height;
          "Mod+Ctrl+R".action = reset-window-height;
          "Mod+F".action = maximize-column;
          "Mod+Shift+F".action = fullscreen-window;
          "Mod+Ctrl+Shift+F".action = toggle-windowed-fullscreen;
          "Mod+Ctrl+F".action = expand-column-to-available-width;

          # Column centering
          "Mod+C".action = center-column;
          "Mod+Ctrl+C".action = center-visible-columns;

          # Manual resizing
          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Equal".action = set-column-width "+10%";
          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";

          # Set preferred size
          "Mod+A".action = set-column-width "30%";
          "Mod+S".action = set-column-width "70%";
          "Mod+Z".action = set-column-width "50%";

          # Floating windows
          "Mod+V".action = toggle-window-floating;
          "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

          # Window tabbing
          "Mod+W".action = toggle-column-tabbed-display;

          # Screenshots
          "Print".action = screenshot;
          "Alt+Print".action.screenshot-screen = [ ];
          "Ctrl+Print".action = screenshot-window;

          # System controls
          "Mod+Escape" = {
            action = toggle-keyboard-shortcuts-inhibit;
            allow-inhibiting = false;
          };
          "Mod+Shift+E".action = quit;
          "Ctrl+Alt+Delete".action = quit;
          "Mod+Shift+P".action = power-off-monitors;
        };
      };
    };
}
