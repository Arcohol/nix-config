{
  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    let
      switch-audio-sink = pkgs.writeShellScript "switch-audio-sink" ''
        CURRENT_SINK=$(pw-metadata -n default 0 default.audio.sink | awk -F'"' '/name/ {print $4}')
        NEXT_SINK_ID=$(pw-dump | ${pkgs.jq}/bin/jq --raw-output --arg default_sink_name "$CURRENT_SINK" '
            map(
              select(.type == "PipeWire:Interface:Node" and .info.props["media.class"] == "Audio/Sink")
                | {id: .id, name: .info.props["node.name"]}
            ) | sort_by(.name) as $sinks
              | $sinks | map(.name) | index($default_sink_name) as $index
              | $sinks[($index + 1) % ($sinks | length)].id
        ')
        wpctl set-default "$NEXT_SINK_ID"
      '';
    in
    {
      programs.waybar = {
        enable = true;
        systemd.enable = true;
        package = pkgs.waybar.overrideAttrs (prev: {
          patches = prev.patches or [ ] ++ [
            (pkgs.fetchpatch {
              url = "https://patch-diff.githubusercontent.com/raw/Alexays/Waybar/pull/4407.patch";
              sha256 = "sha256-r2Ya1siYAasoK28sTJtb+6wqfBx8bTlK6r5SsMclvBk=";
            })
          ];
        });
        settings = [
          {
            position = "top";
            layer = "top";
            modules-left = [ "niri/workspaces" ];
            modules-center = [ "mpris" ];
            modules-right = [
              "wireplumber"
              "cpu"
              "memory"
              "network"
              "clock"
              "battery"
            ];
            mpris = {
              format = "{status_icon} {dynamic}";
              status-icons = {
                playing = "▶";
                paused = "⏸";
              };
              ignored-players = [ "firefox" ];
              dynamic-order = [
                "artist"
                "title"
              ];
              tooltip-format = "";
            };
            wireplumber = {
              format = "VOL {volume}%";
              scroll-step = 5.0;
              on-click = "${switch-audio-sink}";
            };
            cpu = {
              format = "CPU {usage}%";
              interval = 1;
            };
            memory = {
              format = "MEM {percentage}%";
              interval = 1;
            };
            network = {
              interval = 1;
              format = "↓{bandwidthDownBytes} ↑{bandwidthUpBytes}";
              tooltip-format = "{ifname} via {gwaddr}";
            };
            clock = {
              interval = 60;
              align = 0;
              rotate = 0;
              format = "{:%H:%M %Z}";
              format-alt = "{:%a, %b %d, %Y}";
              tooltip-format = "<tt><small>{tz_list}{calendar}</small></tt>";
              timezones = [
                "Europe/Amsterdam"
                "Asia/Shanghai"
                "Asia/Tokyo"
              ];
            };
            battery = {
              interval = 60;
              states = {
                warning = 30;
                critical = 15;
              };
              format = "{capacity}%";
              max-length = 25;
            };
          }
        ];
        style = ''
          @define-color rosewater #f5e0dc;
          @define-color flamingo #f2cdcd;
          @define-color pink #f5c2e7;
          @define-color mauve #cba6f7;
          @define-color red #f38ba8;
          @define-color maroon #eba0ac;
          @define-color peach #fab387;
          @define-color yellow #f9e2af;
          @define-color green #a6e3a1;
          @define-color teal #94e2d5;
          @define-color sky #89dceb;
          @define-color sapphire #74c7ec;
          @define-color blue #89b4fa;
          @define-color lavender #b4befe;
          @define-color text #cdd6f4;
          @define-color subtext1 #bac2de;
          @define-color subtext0 #a6adc8;
          @define-color overlay2 #9399b2;
          @define-color overlay1 #7f849c;
          @define-color overlay0 #6c7086;
          @define-color surface2 #585b70;
          @define-color surface1 #45475a;
          @define-color surface0 #313244;
          @define-color base #1e1e2e;
          @define-color mantle #181825;
          @define-color crust #11111b;

          * {
            font-family: "monospace";
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 0;
          }

          window#waybar {
            background-color: rgba(0, 0, 0, 0.5);
          }

          #workspaces button {
            padding: 0 5px;
            background: transparent;
          }

          #workspaces button.active {
            background-color: #4b367c;
          }

          #mpris,
          #wireplumber,
          #cpu,
          #memory,
          #network,
          #clock,
          #battery {
            padding-right: 10px;
          }

          #mpris {
            color: @mauve;
          }

          #wireplumber {
            color: @flamingo;
          }

          #cpu {
            color: @peach;
          }

          #memory {
            color: @yellow;
          }

          #network {
            color: @blue;
          }

          #clock {
            color: @text;
          }

          #battery {
            color: @green;
          }
        '';
      };
    };
}
