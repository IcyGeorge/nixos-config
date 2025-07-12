{pkgs, ...}: {
  home.packages = with pkgs; [
    waybar
    swaynotificationcenter
  ];
  
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        spacing = 0;
        height = 0;

        "margin-top" = 8;
        "margin-right" = 8;
        "margin-bottom" = 0;
        "margin-left" = 8;

        "modules-left" = [ "niri/workspaces" ];
        "modules-center" = [ "clock" ];
        "modules-right" = [
          "tray"
          "cpu_text"
          "cpu"
          "memory"
          "battery"
          "network"
          "pulseaudio"
        ];

        "niri/workspaces" = {
          "disable-scroll" = true;
          "all-outputs" = true;
          tooltip = false;
        };

        tray = {
          spacing = 10;
          tooltip = false;
        };

        clock = {
          format = "{:%I:%M %p - %a, %d %b %Y}";
          tooltip = false;
        };

        cpu = {
          format = "cpu {usage}%";
          interval = 2;
          states = {
            critical = 90;
          };
        };

        memory = {
          format = "mem {percentage}%";
          interval = 2;
          states = {
            critical = 80;
          };
        };

        battery = {
          format = "bat {capacity}%";
          interval = 5;
          states = {
            warning = 20;
            critical = 10;
          };
          tooltip = false;
        };

        network = {
          "format-wifi" = "wifi {bandwidthDownBits}";
          "format-ethernet" = "enth {bandwidthDownBits}";
          "format-disconnected" = "no network";
          interval = 5;
          tooltip = false;
          "on-click" = "nm-connection-editor";
        };

        pulseaudio = {
          "scroll-step" = 5;
          "max-volume" = 150;
          format = "vol {volume}%";
          "format-bluetooth" = "vol {volume}%";
          nospacing = 1;
          "on-click" = "pwvucontrol";
          tooltip = false;
        };
      };
    };
    style = ''
/* === Base === */
* {
  border: none;
  border-radius: 0;
  min-height: 0;
  font-family: "Maple Mono";
  font-weight: 500;
  font-size: 14px;
  padding: 0;
}

window#waybar {
  background: #282828;         /* bg0 */
  border: 2px solid #3c3836;   /* bg_current_world */
}

/* === Tooltip === */
tooltip {
  background-color: #1b1b1b;  /* bg_dim */
}

tooltip label {
  margin: 6px 10px;
  color: #d4be98;              /* fg1 */
}

#tray menu {
  padding: 6px 6px;
}


/* === Module Defaults === */
#tray,
#cpu,
#memory,
#battery,
#network,
#pulseaudio,
#clock,
#workspaces {
  background-color: #1b1b1b;   /* bg_dim */
  color: #d4be98;              /* fg0 */
  border: 1px solid #3c3836;   /* bg_current_world */
  margin: 6px 6px 6px 0;
  padding: 2px 8px;
}

#workspaces {
  margin: 6px 6px 6px 6px;
  padding: 0px;
}

/* === Workspaces === */
#workspaces button {
  all: initial;
  min-width: 0;
  padding: 2px 10px;
  color: #d4be98;              /* fg1 */
  border-radius: 2px;
}

#workspaces button.focused {
  background-color: #34381b;   /* bg_diff_green */
  color: #a9b665;              /* green */
}

#workspaces button.urgent {
  background-color: #e78a4e;   /* orange */
  color: #1b1b1b;              /* bg_dim */
}

/* === Clock === */
#clock {
  background-color: #1b1b1b;   /* bg_dim */
  border: 1px solid #3c3836;   /* bg_current_world */
  color: #d4be98;              /* fg1 */
}

/* === CPU / Memory / Battery Alerts === */
#battery.warning,
#battery.critical,
#battery.urgent,
#cpu.critical,
#memory.critical {
  color: #ea6962;              /* red */
  border-color: #402120;       /* bg_diff_red */
}

    '';
  };
}
