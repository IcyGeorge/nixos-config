{ userSettings, ... }: 
let 
  super = "Mod4"; 
       
  #navigation
  left = "h";
  down = "j";
  up = "k";
  right = "l";
       
       
 in {
  programs.sway = {
    enable = true;
  };

  home-manager.users.${userSettings.username}.wayland.windowManager.sway = {
    enable = true;
    xwayland = true;

    config = {
      modifier = "Mod4";
      terminal = "foot";
      menu = "wmenu-run";

     keybindings = {
       # --- Application Launch ---
       "${super}+Return" = "exec foot";          # Launch terminal
       "${super}+d" = "exec  wmenu-run";               # Launch application menu
       "${super}+Shift+e" =                      # Exit confirmation dialog
       "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";
       "Print" = "exec grim";                # Screenshot with grim

       # --- Window Management ---
       "${super}+Shift+q" = "kill";              # Close focused window
       "${super}+Shift+c" = "reload";            # Reload config

       # --- Focus Movement ---
       "${super}+${left}" = "focus left";
       "${super}+${down}" = "focus down";
       "${super}+${up}" = "focus up";
       "${super}+${right}" = "focus right";
       "${super}+Left" = "focus left";
       "${super}+Down" = "focus down";
       "${super}+Up" = "focus up";
       "${super}+Right" = "focus right";

       # --- Move Windows ---
       "${super}+Shift+${left}" = "move left";
       "${super}+Shift+${down}" = "move down";
       "${super}+Shift+${up}" = "move up";
       "${super}+Shift+${right}" = "move right";
       "${super}+Shift+Left" = "move left";
       "${super}+Shift+Down" = "move down";
       "${super}+Shift+Up" = "move up";
       "${super}+Shift+Right" = "move right";

       # --- Workspace Switching ---
       "${super}+1" = "workspace number 1";
       "${super}+2" = "workspace number 2";
       "${super}+3" = "workspace number 3";
       "${super}+4" = "workspace number 4";
       "${super}+5" = "workspace number 5";
       "${super}+6" = "workspace number 6";
       "${super}+7" = "workspace number 7";
       "${super}+8" = "workspace number 8";
       "${super}+9" = "workspace number 9";
       "${super}+0" = "workspace number 10";

       # --- Move Window to Workspace ---
       "${super}+Shift+1" = "move container to workspace number 1";
       "${super}+Shift+2" = "move container to workspace number 2";
       "${super}+Shift+3" = "move container to workspace number 3";
       "${super}+Shift+4" = "move container to workspace number 4";
       "${super}+Shift+5" = "move container to workspace number 5";
       "${super}+Shift+6" = "move container to workspace number 6";
       "${super}+Shift+7" = "move container to workspace number 7";
       "${super}+Shift+8" = "move container to workspace number 8";
       "${super}+Shift+9" = "move container to workspace number 9";
       "${super}+Shift+0" = "move container to workspace number 10";

       # --- Layout Modes ---
       "${super}+b" = "splith";                  # Horizontal split
       "${super}+v" = "splitv";                  # Vertical split
       "${super}+s" = "layout stacking";         # Stacking layout
       "${super}+w" = "layout tabbed";           # Tabbed layout
       "${super}+e" = "layout toggle split";     # Toggle split orientation
       "${super}+f" = "fullscreen";              # Toggle fullscreen

       # --- Floating / Scratchpad ---
       "${super}+Shift+space" = "floating toggle"; # Toggle floating mode
       "${super}+space" = "focus mode_toggle";     # Toggle focus mode
       "${super}+Shift+minus" = "move scratchpad"; # Send to scratchpad
       "${super}+minus" = "scratchpad show";       # Show scratchpad
       
       # --- Media / Audio / Brightness Controls ---
       "${super}+Print" = "exec grim"; # Screenshot

       # PulseAudio volume controls
       "--locked XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
       "--locked XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
       "--locked XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
       "--locked XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";

       # Brightness control
       "--locked XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
       "--locked XF86MonBrightnessUp" = "exec brightnessctl set 5%+";

       # --- Modes ---
       "${super}+r" = "mode \"resize\"";          # Enter resize mode

      };
      bars = [
        {
           position = "top";
           statusCommand = ''
             while date +'%Y-%m-%d %X'; do sleep 1; done
           '';
          colors = {
            statusline = "#ffffff";
            background = "#323232";
            inactiveWorkspace = {
              border = "#32323200";
              background = "#32323200";
              text = "#5c5c5c";
            };
          };
        }
      ];
      
      modes = {
        resize = {
          "Return" = "mode \"default\"";
          "Escape" = "mode \"default\"";
          
          "${left}" = "resize shrink width 10px";
          "${down}" = "resize grow height 10px";
          "${up}" = "resize shrink height 10px";
          "${right}" = "resize grow width 10px";
          "Left" = "resize shrink width 10px";
          "Down" = "resize grow height 10px";
          "Up" = "resize shrink height 10px";
          "Right" = "resize grow width 10px";
        };
      };

      # Background image
      output = {
        "*" = {
          #bg = "/run/current-system/sw/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png fill";
        };
      };
    };
    
    
     extraConfig = ''
      # Import the most important environment variables into the D-Bus and systemd
      # user environments (e.g. required for screen sharing and Pinentry prompts):
      exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP
      # enable systemd-integration
      exec "systemctl --user import-environment {,WAYLAND_}DISPLAY SWAYSOCK; systemctl --user start sway-session.target"
      exec swaymsg -t subscribe '["shutdown"]' && systemctl --user stop sway-session.target
    '';
  };
}
