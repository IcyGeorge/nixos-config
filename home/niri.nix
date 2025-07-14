{config, lib, pkgs, ...}:
let
  configDirectory = config.var.configDirectory;
in
{

  home.packages = with pkgs; [
    swaybg
    xwayland-satellite-unstable
  ];

  programs.niri.package = pkgs.niri-unstable;
  programs.niri.settings = {
    xwayland-satellite.path = "${lib.getExe pkgs.xwayland-satellite-unstable}";
    environment = {
      XDG_CURRENT_DESKTOP = "Niri";
      XDG_SESSION_TYPE    = "wayland";
      XDG_SESSION_DESKTOP = "Niri";

      MOZ_ENABLE_WAYLAND            = "1";
      NIXOS_OZONE_WL                = "1";
      QT_QPA_PLATFORM               = "wayland,xcb";
      #QT_AUTO_SCREEN_SCALE_FACTOR   = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      ELECTRON_OZONE_PLATFORM_HINT  = "auto";
      SDL_VIDEODRIVER               = "wayland";
      CLUTTER_BACKEND               = "wayland";
    };
    prefer-no-csd = true;
    spawn-at-startup = [
      { command = ["waybar"]; }
      { command = [ "sh" "-c" "swaybg -i ${configDirectory}/assets/wallpapers/wallpaper.jpg" ]; } 
    ];
    input = {
      focus-follows-mouse = {
        max-scroll-amount = "0%";
      };

      keyboard = {
        numlock = true;
        xkb = {
          layout = "us";
          options = "grp:alt_shift_toggle,caps:escape";
        };
      };

      touchpad = {
        tap = true;
        natural-scroll = true;
      };

      warp-mouse-to-focus.enable = true;
    };

    layout = {
      gaps = 8;
      center-focused-column = "never";
      preset-column-widths = [ 
        { proportion = 0.33333; } 
        { proportion = 0.5; }
        { proportion = 0.66667; } 
      ];
      default-column-width = { proportion = 0.5; };

      focus-ring = {
        enable = false;
        width = 2;
        urgent.color = "#9b0000";
        active.gradient = {
          from = "#d8a657";
          to = "#ea6962";
          angle = 45;
          relative-to = "workspace-view";
        };
        inactive.gradient = {
          from = "#3c3836";
          to = "#282828";
          angle = 45;
          relative-to = "workspace-view";
        };
      };

      border = {
        enable = true;
        width = 2;
        urgent.color = "#9b0000";
        active.gradient = {
          from = "#a9b665";
          to = "#d8a657";
          angle = 45;
          relative-to = "workspace-view";
        };
        inactive.gradient = {
          from = "#3c3836";
          to = "#282828";
          angle = 45;
          relative-to = "workspace-view";
        };
      };
      shadow.enable = true;
      tab-indicator = {
        position = "left";
        gaps-between-tabs = 10;
      };
    };
    cursor = {
      hide-after-inactive-ms = 5000;
    };

    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    binds = with config.lib.niri.actions; {
      "Mod+Shift+Slash".action = show-hotkey-overlay;

      # ── Application Launchers ── 
      "Mod+Return".hotkey-overlay.title = "Open a Terminal: foot";
      "Mod+Return".action = spawn "foot";

      "Mod+D".hotkey-overlay.title = "Run an Application: fuzzel";
      "Mod+D".action = spawn "fuzzel";

      "Super+Alt+L".hotkey-overlay.title = "Lock the Screen: swaylock";
      "Super+Alt+L".action = spawn "swaylock";

      # ── Volume Control (PipeWire) ── 
      "XF86AudioRaiseVolume".allow-when-locked = true;
      "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";

      "XF86AudioLowerVolume".allow-when-locked = true;
      "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";

      "XF86AudioMute".allow-when-locked = true;
      "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";

      "XF86AudioMicMute".allow-when-locked = true;
      "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
      
      # ── Window Management ── 
      "Mod+Q".action = close-window;

      # ── Focus Movement ── 
      "Mod+Left".action = focus-column-left;
      "Mod+Down".action = focus-window-down;
      "Mod+Up".action = focus-window-up;
      "Mod+Right".action = focus-column-right;
      "Mod+H".action = focus-column-left;
      "Mod+J".action = focus-window-down;
      "Mod+K".action = focus-window-up;
      "Mod+L".action = focus-column-right;

      # ── Move Window/Column ── 
      "Mod+Ctrl+Left".action = move-column-left;
      "Mod+Ctrl+Down".action = move-window-down;
      "Mod+Ctrl+Up".action = move-window-up;
      "Mod+Ctrl+Right".action = move-column-right;
      "Mod+Ctrl+H".action = move-column-left;
      "Mod+Ctrl+J".action = move-window-down;
      "Mod+Ctrl+K".action = move-window-up;
      "Mod+Ctrl+L".action = move-column-right;

      # ── Column Navigation ──
      "Mod+Home".action = focus-column-first;
      "Mod+End".action = focus-column-last;
      "Mod+Ctrl+Home".action = move-column-to-first;
      "Mod+Ctrl+End".action = move-column-to-last;

      # ── Monitor Navigation ──
      "Mod+Shift+Left".action = focus-monitor-left;
      "Mod+Shift+Down".action = focus-monitor-down;
      "Mod+Shift+Up".action = focus-monitor-up;
      "Mod+Shift+Right".action = focus-monitor-right;
      "Mod+Shift+H".action = focus-monitor-left;
      "Mod+Shift+J".action = focus-monitor-down;
      "Mod+Shift+K".action = focus-monitor-up;
      "Mod+Shift+L".action = focus-monitor-right;

      # ── Move Column Between Monitors ── 
      "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
      "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
      "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
      "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
      "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
      "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

      # ── Workspace Navigation ── 
      "Mod+Page_Down".action = focus-workspace-down;
      "Mod+Page_Up".action = focus-workspace-up;
      "Mod+U".action = focus-workspace-down;
      "Mod+I".action = focus-workspace-up;

      # ── Move Column Between Workspaces ── 
      "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
      "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
      "Mod+Ctrl+U".action = move-column-to-workspace-down;
      "Mod+Ctrl+I".action = move-column-to-workspace-up;

      # ── Move Whole Workspaces ── 
      "Mod+Shift+Page_Down".action = move-workspace-down;
      "Mod+Shift+Page_Up".action = move-workspace-up;
      "Mod+Shift+U".action = move-workspace-down;
      "Mod+Shift+I".action = move-workspace-up;

      # ── Workspace Switching by Index ── 
      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;
      "Mod+6".action = focus-workspace 6;
      "Mod+7".action = focus-workspace 7;
      "Mod+8".action = focus-workspace 8;
      "Mod+9".action = focus-workspace 9;

      # ── Move Column to Workspace by Index ── 
      #"Mod+Ctrl+1".action = move-column-to-workspace 1;
      #"Mod+Ctrl+2".action = move-column-to-workspace 2;
      #"Mod+Ctrl+3".action = move-column-to-workspace 3;
      #"Mod+Ctrl+4".action = move-column-to-workspace 4;
      #"Mod+Ctrl+5".action = move-column-to-workspace 5;
      #"Mod+Ctrl+6".action = move-column-to-workspace 6;
      #"Mod+Ctrl+7".action = move-column-to-workspace 7;
      #"Mod+Ctrl+8".action = move-column-to-workspace 8;
      #"Mod+Ctrl+9".action = move-column-to-workspace 9;

      # ── Column Manipulation ── 
      "Mod+BracketLeft".action = consume-or-expel-window-left;
      "Mod+BracketRight".action = consume-or-expel-window-right;
      "Mod+Comma".action = consume-window-into-column;
      "Mod+Period".action = expel-window-from-column;

      # ── Layout Adjustments ── 
      "Mod+R".action = switch-preset-column-width;
      "Mod+Shift+R".action = switch-preset-window-height;
      "Mod+Ctrl+R".action = reset-window-height;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+Ctrl+F".action = expand-column-to-available-width;
      "Mod+C".action = center-column;
      "Mod+Ctrl+C".action = center-visible-columns;

      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";
      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";

      # ── Floating / Tiling Layout ── 
      "Mod+V".action = toggle-window-floating;
      "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

      # ── Tabbed Column Mode ── 
      "Mod+W".action = toggle-column-tabbed-display;

      # ── Overview Mode ──────
      "Mod+O".repeat = false;
      "Mod+O".action = toggle-overview;

      # ── Screenshot Bindings ── 
      "Print".action = screenshot;
      #"Ctrl+Print".action = screenshot-screen;
      "Alt+Print".action = screenshot-window;

      # ── Mouse Wheel Workspace Navigation ── 
      "Mod+WheelScrollDown".cooldown-ms = 150;
      "Mod+WheelScrollDown".action = focus-workspace-down;
      "Mod+WheelScrollUp".cooldown-ms = 150;
      "Mod+WheelScrollUp".action = focus-workspace-up;

      # ── Mouse Wheel Column Movement ── 
      "Mod+WheelScrollRight".action = focus-column-right;
      "Mod+WheelScrollLeft".action = focus-column-left;
      "Mod+Ctrl+WheelScrollRight".action = move-column-right;
      "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

      # ── Horizontal Scroll with Shift ── 
      "Mod+Shift+WheelScrollDown".action = focus-column-right;
      "Mod+Shift+WheelScrollUp".action = focus-column-left;
      "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
      "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

      # ── Toggle Keyboard Shortcut Inhibition ── 
      "Mod+Escape".allow-inhibiting = false;
      "Mod+Escape".action = toggle-keyboard-shortcuts-inhibit;

      # ── Quit & Exit ── 
      "Mod+Shift+E".action = quit;
      "Ctrl+Alt+Delete".action = quit;

      # ── Power Controls ── 
      "Mod+Shift+P".action = power-off-monitors;

    };
  };
}
