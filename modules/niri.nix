{ config, inputs, lib, pkgs, ... }:
let
  configDirectory = config.var.configDirectory;
in
{
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
  home-manager.users.${config.var.username} = {
    home.packages = with pkgs; [
      swaybg
      xwayland-satellite-unstable
      playerctl
      brightnessctl
      bemoji
    ];

    programs.niri.package = pkgs.niri-unstable;
    programs.niri.config = builtins.readFile (pkgs.replaceVars ../dots/niri/niri.kdl {
      cursorTheme = "Bibata-Modern-Ice";
      swaync = "${pkgs.swaynotificationcenter}";
      copyq = "${pkgs.copyq}";
      #  cursorTheme = "${config.gtk.cursorTheme.name}";
      kitty = "${pkgs.kitty}";
      fuzzel = "${pkgs.fuzzel}";
      wireplumber = "${pkgs.wireplumber}";
      playerctl = "${pkgs.playerctl}";
      brightnessctl = "${pkgs.brightnessctl}";
      bemoji = "${pkgs.bemoji}";
      swayexitify = null;
      niriswitch = null;
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
