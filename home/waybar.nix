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
          "on-click" = "alacritty nmtui";
        };

        pulseaudio = {
          "scroll-step" = 5;
          "max-volume" = 150;
          format = "vol {volume}%";
          "format-bluetooth" = "vol {volume}%";
          nospacing = 1;
          "on-click" = "pavucontrol";
          tooltip = false;
        };
      };
    };
    style = ''
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
      background: #282828; /* bg */
      border: 2px solid #3c3836; /* bg2 */
    }

    tooltip {
      background-color: #282828; /* bg */
      border: 2px solid #504945; /* bg3 */
    }

    tooltip label {
      color: #d4be98; /* fg */
    }

    #clock,
    #tray,
    #cpu,
    #memory,
    #battery,
    #network,
    #pulseaudio {
      margin: 6px 6px 6px 0px;
      padding: 2px 8px;
    }

    #workspaces {
      background-color: #32302f; /* bg1 */
      margin: 6px 0px 6px 6px;
      border: 2px solid #504945; /* bg3 */
    }

    #workspaces button {
      all: initial;
      min-width: 0;
      box-shadow: inset 0 -3px transparent;
      padding: 2px 4px;
      color: #d4be98; /* fg */
    }

    #workspaces button.focused {
      color: #d8a657; /* yellow */
    }

    #workspaces button.urgent {
      background-color: #e78a4e; /* orange */
    }

    #clock {
      background-color: #32302f; /* bg1 */
      border: 2px solid #504945; /* bg3 */
      color: #d4be98; /* fg */
    }

    #tray {
      background-color: #d4be98; /* fg */
      border: 2px solid #d8a657; /* yellow */
    }

    #battery {
      background-color: #a9b665; /* green */
      border: 2px solid #d8a657; /* yellow */
      color: #32302f; /* bg1 */
    }

    #cpu,
    #memory,
    #network,
    #pulseaudio {
      background-color: #d4be98; /* fg */
      border: 2px solid #d8a657; /* yellow */
      color: #282828; /* bg */
    }

    #cpu.critical,
    #memory.critical {
      background-color: #d4be98; /* fg */
      border: 2px solid #d8a657; /* yellow */
      color: #ea6962; /* red */
    }

    #battery.warning,
    #battery.critical,
    #battery.urgent {
      background-color: #d4be98; /* fg */
      border: 2px solid #d8a657; /* yellow */
      color: #ea6962; /* red */
    }

    '';
  };
}
