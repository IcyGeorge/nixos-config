{ userSettings, userThemes, ... }:

let
  super = "Mod4";

  # Navigation keys
  left  = "h";
  down  = "j";
  up    = "k";
  right = "l";

  color_unused = "#ff0000";

in {
  programs.sway.enable = true;

  home-manager.users.${userSettings.username}.wayland.windowManager.sway = {
    enable = true;
    xwayland = true;

    config = {
      modifier = super;
      terminal = "foot";
      menu     = "wmenu-run";

      input = {
        "type:touchpad" = {
          dwt              = "enabled";
          tap              = "enabled";
          natural_scroll   = "enabled";
          middle_emulation = "enabled";
        };
      };

      gaps = {
        inner     = 5;
        smartGaps = true;
      };

      window.hideEdgeBorders = "none";

      workspaceLayout = "tabbed";

      keybindings = {
        # --- Application Launch ---
        "${super}+Return"    = "exec foot";
        "${super}+d"         = "exec wmenu-run";
        "${super}+Shift+e"   = ''
          exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'
        '';
        "Print"              = "exec grim";

        # --- Window Management ---
        "${super}+Shift+q" = "kill";
        "${super}+Shift+c" = "reload";

        # --- Focus Movement ---
        "${super}+${left}"  = "focus left";
        "${super}+${down}"  = "focus down";
        "${super}+${up}"    = "focus up";
        "${super}+${right}" = "focus right";
        "${super}+Left"     = "focus left";
        "${super}+Down"     = "focus down";
        "${super}+Up"       = "focus up";
        "${super}+Right"    = "focus right";

        # --- Move Windows ---
        "${super}+Shift+${left}"  = "move left";
        "${super}+Shift+${down}"  = "move down";
        "${super}+Shift+${up}"    = "move up";
        "${super}+Shift+${right}" = "move right";
        "${super}+Shift+Left"     = "move left";
        "${super}+Shift+Down"     = "move down";
        "${super}+Shift+Up"       = "move up";
        "${super}+Shift+Right"    = "move right";

        # --- Layout Modes ---
        "${super}+b" = "splith";
        "${super}+v" = "splitv";
        "${super}+s" = "layout stacking";
        "${super}+w" = "layout tabbed";
        "${super}+e" = "layout toggle split";
        "${super}+f" = "fullscreen";

        # --- Floating / Scratchpad ---
        "${super}+Shift+space" = "floating toggle";
        "${super}+space"       = "focus mode_toggle";
        "${super}+Shift+minus"     = "move scratchpad";
        "${super}+minus"           = "scratchpad show";

        # --- Media / Audio / Brightness Controls ---
        "--locked XF86AudioMute"         = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "--locked XF86AudioLowerVolume"  = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "--locked XF86AudioRaiseVolume"  = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "--locked XF86AudioMicMute"      = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        "--locked XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "--locked XF86MonBrightnessUp"   = "exec brightnessctl set 5%+";

        # --- Modes ---
        "${super}+r" = "mode \"resize\"";
      };

      bars = [{
        position = "top";
        statusCommand = ''
          while date +'%Y-%m-%d %X'; do sleep 1; done
        '';
        colors = {
          statusline = "#ffffff";
          background = "#323232";
          inactiveWorkspace = {
            border     = "#32323200";
            background = "#32323200";
            text       = "#5c5c5c";
          };
        };
      }];

      modes.resize = {
        "Return" = "mode default";
        "Escape" = "mode default";

        "${left}"  = "resize shrink width 10px";
        "${down}"  = "resize grow height 10px";
        "${up}"    = "resize shrink height 10px";
        "${right}" = "resize grow width 10px";

        "Left"     = "resize shrink width 10px";
        "Down"     = "resize grow height 10px";
        "Up"       = "resize shrink height 10px";
        "Right"    = "resize grow width 10px";
      };

      colors = {
        focused = {
          border       = userThemes.gruvbox.darkGray;
          background   = userThemes.gruvbox.darkGray;
          text         = userThemes.gruvbox.fg;
          indicator    = userThemes.gruvbox.darkGray;
          childBorder  = userThemes.gruvbox.bg;
        };
        focusedInactive = {
          border       = userThemes.gruvbox.darkGray;
          background   = userThemes.gruvbox.darkGray;
          text         = userThemes.gruvbox.fg;
          indicator    = userThemes.gruvbox.darkGray;
          childBorder  = userThemes.gruvbox.bg;
        };
        unfocused = {
          border       = userThemes.gruvbox.bg;
          background   = userThemes.gruvbox.bg;
          text         = userThemes.gruvbox.gray;
          indicator    = userThemes.gruvbox.bg;
          childBorder  = userThemes.gruvbox.bg;
        };
        urgent = {
          border       = userThemes.gruvbox.yellow;
          background   = userThemes.gruvbox.yellow;
          text         = userThemes.gruvbox.bg;
          indicator    = color_unused;
          childBorder  = color_unused;
        };
        placeholder = {
          border       = color_unused;
          background   = color_unused;
          text         = color_unused;
          indicator    = color_unused;
          childBorder  = color_unused;
        };
      };

      output."*" = {
        # bg = "/path/to/wallpaper fill";
      };
    };

    extraConfig = ''
      exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP
      exec "systemctl --user import-environment {,WAYLAND_}DISPLAY SWAYSOCK; systemctl --user start sway-session.target"
      exec swaymsg -t subscribe '["shutdown"]' && systemctl --user stop sway-session.target
    '';
  };
}

