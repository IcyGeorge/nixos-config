{ config, lib, pkgs, ... }:

let
  inherit (lib) genAttrs range;

  configDirectory = config.var.configDirectory;

  mod = "Mod4";
  term = "foot";
  menu = "fuzzel";

  left = "h";
  down = "j";
  up = "k";
  right = "l";

  workspace1 = "workspace number 1";
  workspace2 = "workspace number 2";
  workspace3 = "workspace number 3";
  workspace4 = "workspace number 4";
  workspace5 = "workspace number 5";
  workspace6 = "workspace number 6";
  workspace7 = "workspace number 7";
  workspace8 = "workspace number 8";
  workspace9 = "workspace number 9";
  workspace10 = "workspace number 10";

in
{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  home-manager.users.${config.var.username} = {
    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland,xcb";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };

    wayland.windowManager.sway = {
      enable = true;
      xwayland = true;
      package = pkgs.sway;
      checkConfig = false;
      config = {
        modifier = mod;
        terminal = term;
        menu = menu;
        floating.modifier = mod;

        input = {
          "*".xkb_options = "grp:alt_shift_toggle,caps:escape";
          "*" = {
            tap = "enabled";
            dwt = "enabled";
            natural_scroll = "enabled";
          };
        };
        output = {
          "*".bg = "${configDirectory}/assets/wallpapers/wallpaper.jpg fill";
          HDMI-A-1 = {
            scale = "1.5";
            position = "0 -2560";
          };
        };


        fonts = {
          names = [ "Maple Mono" ];
          style = "Bold";
          size = 14.0;
        };

        gaps = {
          inner = 5;
          outer = 0;
          smartGaps = true;
        };



        colors =
          let
            color_fg = "#d4be98"; # foreground
            color_bg = "#282828"; # background
            color_bg2 = "#3c3836"; # slightly lighter bg
            color_black = "#1d2021"; # dark gray/black
            color_accent = "#a9b665"; # green accent
            color_orange = "#e78a4e"; # yellow (used for urgent)
            color_bg_diff_green = "#32361a"; # diff add background (green)
            color_dim = "#1b1b1b"; # dim background (dark)
          in
          {
            focused = {
              border = color_bg_diff_green;
              background = color_bg_diff_green;
              text = color_accent;
              indicator = color_bg_diff_green;
              childBorder = color_bg_diff_green;
            };
            focusedInactive = {
              border = color_bg2;
              background = color_bg2;
              text = color_fg;
              indicator = color_bg2;
              childBorder = color_black;
            };
            unfocused = {
              border = color_bg;
              background = color_bg;
              text = color_fg;
              indicator = color_bg;
              childBorder = color_black;
            };
            urgent = {
              border = color_orange;
              background = color_orange;
              text = color_dim;
              indicator = color_orange;
              childBorder = color_orange;
            };
            placeholder = {
              border = color_black;
              background = color_black;
              text = color_black;
              indicator = color_black;
              childBorder = color_black;
            };
          };

        keybindings = {

          # ---- static bindings ------------------------------------------------
          "${mod}+Return" = "exec ${term}";
          "${mod}+Shift+q" = "kill";
          "${mod}+d" = "exec ${menu}";

          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+e" =
            ''exec swaynag -t warning \
                -m "You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session." \
                -B "Yes, exit sway" "swaymsg exit"'';

          # focus ----------------------------------------------------------------
          "${mod}+${left}" = "focus left";
          "${mod}+${down}" = "focus down";
          "${mod}+${up}" = "focus up";
          "${mod}+${right}" = "focus right";
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          # move ---------------------------------------------------------------
          "${mod}+Shift+${left}" = "move left";
          "${mod}+Shift+${down}" = "move down";
          "${mod}+Shift+${up}" = "move up";
          "${mod}+Shift+${right}" = "move right";
          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

          # ---- workspace jump / move bindings (1‒10) ---------------------------
          "${mod}+1" = "${workspace1}";
          "${mod}+2" = "${workspace2}";
          "${mod}+3" = "${workspace3}";
          "${mod}+4" = "${workspace4}";
          "${mod}+5" = "${workspace5}";
          "${mod}+6" = "${workspace6}";
          "${mod}+7" = "${workspace7}";
          "${mod}+8" = "${workspace8}";
          "${mod}+9" = "${workspace9}";
          "${mod}+0" = "${workspace10}";

          "${mod}+Shift+1" = "move container to ${workspace1}";
          "${mod}+Shift+2" = "move container to ${workspace2}";
          "${mod}+Shift+3" = "move container to ${workspace3}";
          "${mod}+Shift+4" = "move container to ${workspace4}";
          "${mod}+Shift+5" = "move container to ${workspace5}";
          "${mod}+Shift+6" = "move container to ${workspace6}";
          "${mod}+Shift+7" = "move container to ${workspace7}";
          "${mod}+Shift+8" = "move container to ${workspace8}";
          "${mod}+Shift+9" = "move container to ${workspace9}";
          "${mod}+Shift+0" = "move container to ${workspace10}";

          # layout -------------------------------------------------------------
          "${mod}+b" = "splith";
          "${mod}+v" = "splitv";
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";
          "${mod}+f" = "fullscreen";
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+a" = "focus parent";
          "${mod}+r" = "mode resize";

          # scratchpad ---------------------------------------------------------
          "${mod}+Shift+minus" = "move scratchpad";
          "${mod}+minus" = "scratchpad show";
        };

        # Resize mode
        modes.resize = {
          "${left}" = "resize shrink width 10px";
          "${down}" = "resize grow height 10px";
          "${up}" = "resize shrink height 10px";
          "${right}" = "resize grow width 10px";
          "Left" = "resize shrink width 10px";
          "Down" = "resize grow height 10px";
          "Up" = "resize shrink height 10px";
          "Right" = "resize grow width 10px";
          "Return" = "mode default";
          "Escape" = "mode default";
        };

        bars = [ ];
      };

      extraConfig = ''
        # media / volume
        bindsym --locked XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle
        bindsym --locked XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -5%
        bindsym --locked XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +5%
        bindsym --locked XF86AudioMicMute exec pactl set-source-mute @DEFAULT_SOURCE@ toggle

        # media playback
        bindsym --locked XF86AudioPlay  exec playerctl play-pause
        bindsym --locked XF86AudioPause exec playerctl play-pause
        bindsym --locked XF86AudioPrev  exec playerctl previous
        bindsym --locked XF86AudioNext  exec playerctl next
        bindsym --locked XF86AudioStop  exec playerctl stop

        # brightness
        bindsym --locked XF86MonBrightnessDown exec brightnessctl set 5%-
        bindsym --locked XF86MonBrightnessUp   exec brightnessctl set 5%+

        # screenshot
        bindsym Print exec grim
        
        # title
        title_align center
      '';
    };
  };
}

