{ config, inputs, lib, pkgs, ... }:
let
  configDirectory = config.var.configDirectory;
  swayexitify = pkgs.writeShellScriptBin "swayexitify" ''
    lock() {
      ${pkgs.swaylock}/bin/swaylock
    }

    case "$1" in
        lock)
            lock &
            ;;
        logout)
            ${pkgs.sway}/bin/swaymsg exit
            ;;
        suspend)
            ${pkgs.systemd}/bin/systemctl suspend
            ;;
        hibernate)
            ${pkgs.systemd}/bin/systemctl hibernate
            ;;
        reboot)
            ${pkgs.systemd}/bin/systemctl reboot
            ;;
        shutdown)
            ${pkgs.systemd}/bin/systemctl poweroff
            ;;
        *)
            echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
            exit 2
    esac

    exit 0
  '';
  niriswitch = pkgs.writeShellScriptBin "niriswitch" ''
    windows=$(${pkgs.niri}/bin/niri msg -j windows)
    ${pkgs.niri}/bin/niri msg action focus-window --id \
      $(echo "$windows" | 
        ${pkgs.jq}/bin/jq ".[$(echo "$windows" | ${pkgs.jq}/bin/jq -r 'map("\(.title // .app_id)\u0000icon\u001f\(.app_id)") | .[]' | ${pkgs.fuzzel}/bin/fuzzel -d --index)].id"
      )
  '';
in
{
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
  home-manager.users.${config.var.username} = {
    home.packages = with pkgs; [
      xwayland-satellite-unstable
    ];

    programs.niri.package = pkgs.niri-unstable;
    programs.niri.config = builtins.readFile (pkgs.replaceVars ../dots/niri/niri.kdl {
      cursorTheme = "Bibata-Modern-Ice";
      swaync = "${pkgs.swaynotificationcenter}";
      clipse = "${pkgs.clipse}";
      kitty = "${pkgs.kitty}";
      fuzzel = "${pkgs.fuzzel}";
      wireplumber = "${pkgs.wireplumber}";
      playerctl = "${pkgs.playerctl}";
      brightnessctl = "${pkgs.brightnessctl}";
      bemoji = "${pkgs.bemoji}";
      swayexitify = swayexitify;
      niriswitch = niriswitch;
      wlkbptr = "${pkgs.wl-kbptr}";
      wlrctl = "${pkgs.wlrctl}";
      # bash = "${pkgs.bash}";
      # coreutils = "${pkgs.coreutils}";
      DEFAULT_AUDIO_SINK = null;
      DEFAULT_AUDIO_SOURCE = null;
    });

    systemd.user.services.swaybg = {
      Unit = {
        Description = "Wayland Background";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };

      Service = {
        Type = "exec";
        ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${../assets/wallpapers/wallpaper.jpg} -m fill";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    systemd.user.services.xwayland-satellite = {
      Unit = {
        Description = "XWayland Satellite";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
        X-SwitchMethod = "keep-old"; # Do not restart on home-manager switch
      };

      Service = {
        Type = "exec";
        ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
