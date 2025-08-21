{ config, pkgs, ... }:

let
  configDirectory = config.var.configDirectory;

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
  environment.variables = {
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    # QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    CLUTTER_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "sway";
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  home-manager.users.${config.var.username} = {
    wayland.windowManager.sway = {
      enable = true;
      config = null;
      checkConfig = false;
      extraConfig = builtins.readFile (pkgs.replaceVars ../dots/sway/config {
        kitty = "${pkgs.kitty}";
        fuzzel = "${pkgs.fuzzel}";
        configDirectory = configDirectory;
        color_fg = color_fg;
        color_bg = color_bg;
        color_bg2 = color_bg2;
        color_black = color_black;
        color_accent = color_accent;
        color_orange = color_orange;
        color_bg_diff_green = color_bg_diff_green;
        color_dim = color_dim;
      });
    };
  };
}

