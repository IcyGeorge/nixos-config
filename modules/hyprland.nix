{ config, inputs, pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  home-manager.users.${config.var.username} = { config, ... }: {
    xdg.configFile."uwsm/env".source =
      "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;

      xwayland.enable = true;
      systemd.enable = true;
      systemd.variables = [ "--all" ];
      settings = {

        ################################
        # MONITOR                      #
        ################################
        monitor = ",preferred,auto,1";

        ################################
        # USER VARIABLES               #
        ################################
        "$terminal" = "kitty";
        "$fileManager" = "nemo";
        "$menu" = "fuzzel";
        "$mainMod" = "SUPER";

        ################################
        # AUTOSTART                    #
        ################################
        "exec-once" = [
          "$terminal"
          "uwsm app -- nm-applet &"
          "uwsm app -- blueman-applet &"
          "uwsm app -- waybar"
        ];

        ################################
        # ENVIRONMENT                  #
        ################################
        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
          "MOZ_ENABLE_WAYLAND,1"
          "NIXOS_OZONE_WL,1"
          "QT_QPA_PLATFORM,wayland"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "ELECTRON_OZONE_PLATFORM_HINT,wayland"
          "CLUTTER_BACKEND,wayland"
          "SDL_VIDEODRIVER,wayland"
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "XDG_SESSION_DESKTOP,Hyprland"
        ];

        ################################
        # GENERAL                      #
        ################################
        general = {
          gaps_in = 2;
          gaps_out = 4;
          border_size = 2;
          "col.active_border" = "rgba(a9b665ee) rgba(d8a657ee) 45deg";
          "col.inactive_border" = "rgba(3c3836ee)";
          resize_on_border = false;
          allow_tearing = false;
          no_border_on_floating = false;
          layout = "dwindle";
        };

        ################################
        # DECORATION                   #
        ################################
        decoration = {
          rounding = 2;
          #rounding_power = 2;
          active_opacity = 0.92;
          inactive_opacity = 0.76;
          dim_inactive = false;
          dim_strength = 0.04;
          shadow = {
            enabled = false;
            range = 4;
            render_power = 3;
            color = "rgba(1b1b1bee)";
          };
          blur = {
            enabled = true;
            size = 5;
            passes = 5;
            popups = true;
            special = true;
            new_optimizations = true;
            ignore_opacity = true;
          };
        };

        ################################
        # ANIMATIONS                   #
        ################################
        animations = {
          enabled = true;
          first_launch_animation = true;

          bezier = [
            "drag, 0.2, 1, 0.2, 1"
            "pop, 0.1, 0.8, 0.2, 1"
            "liner, 1, 1, 1, 1"
          ];

          animation = [
            "fade, 1, 5, drag"

            "windowsIn, 1, 6, drag, slide"
            "windowsOut, 1, 10, pop, popin 75%"
            "windowsMove, 1, 6, drag, slide"
            "fadeIn, 1, 5, drag"
            "fadeOut, 1, 5, drag"
            "fadeSwitch, 1, 12, drag"

            "layersIn, 1, 7, drag, slide"
            "layersOut, 1, 20, drag"
            "fadeLayersIn, 1, 5, drag"
            "fadeLayersOut, 1, 10, drag"

            "border, 1, 1, liner"
            "borderangle, 1, 30, liner, loop"

            "workspacesIn, 1, 7, drag, slidefade 40%"
            "workspacesOut, 1, 7, drag, slidefade 40%"

            "specialWorkspaceIn, 1, 6, drag, slidefadevert 80%"
            "specialWorkspaceOut, 1, 6, drag, slidefadevert 65%"
          ];
        };

        ################################
        # LAYOUT: DWINDLE              #
        ################################
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        ################################
        # MASTER                       #
        ################################
        master = { new_status = "master"; };

        ################################
        # MISC                         #
        ################################
        misc = {
          force_default_wallpaper = -1;
          disable_hyprland_logo = false;
          font_family = "Maple Mono";
          splash_font_family = "Maple Mono";
        };

        ################################
        # INPUT                        #
        ################################
        input = {
          kb_layout = "us";
          kb_variant = "";
          kb_model = "";
          kb_options = "caps:escape";
          kb_rules = "";
          follow_mouse = 1;
          sensitivity = 0;
          touchpad = { natural_scroll = false; };
        };

        ################################
        # GESTURES                     #
        ################################
        gestures = { workspace_swipe = false; };

        ################################
        # PER-DEVICE INPUT             #
        ################################
        device = {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        };

        ################################
        # KEYBINDINGS                  #
        ################################
        bind = [
          "$mainMod, Q, exec, $terminal"
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$mainMod, R, exec, $menu"
          "$mainMod, P, pseudo,"
          "$mainMod, J, togglesplit,"

          # move focus
          "$mainMod, left,  movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up,    movefocus, u"
          "$mainMod, down,  movefocus, d"

          # workspaces
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # move to workspace
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # scratchpad
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"

          # scroll workspaces
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up,   workspace, e-1"
        ];

        ################################
        # MOUSE BINDS                  #
        ################################
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        ################################
        # LAPTOP KEYS                  #
        ################################
        bindel = [
          ",XF86AudioRaiseVolume,   exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume,   exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute,          exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute,       exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp,    exec, brightnessctl -e4 -n2 set 5%+"
          ",XF86MonBrightnessDown,  exec, brightnessctl -e4 -n2 set 5%-"
        ];

        ################################
        # MEDIA KEYS                   #
        ################################
        bindl = [
          ",XF86AudioNext,    exec, playerctl next"
          ",XF86AudioPause,   exec, playerctl play-pause"
          ",XF86AudioPlay,    exec, playerctl play-pause"
          ",XF86AudioPrev,    exec, playerctl previous"
        ];

        ################################
        # WINDOW RULES                 #
        ################################
        windowrule = [
          "suppressevent maximize, class:.*"
          "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        ];
      };
    };
  };
}

