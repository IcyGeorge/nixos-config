{ config, inputs, pkgs, ... }:
let
  hyprlandPkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
  hyprpaperPkgs = inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system};
  configDirectory = config.var.configDirectory;
in
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = hyprlandPkgs.hyprland;
    portalPackage = hyprlandPkgs.xdg-desktop-portal-hyprland;
  };

  home-manager.users.${config.var.username} = { config, ... }: {
    xdg.configFile."uwsm/env".source =
      "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

    home.packages = with pkgs; [
      hyprpicker
      wl-clipboard
      cliphist
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      xwayland.enable = true;
      systemd.enable = true;
      systemd.variables = [ "--all" ];
      extraConfig = builtins.readFile (pkgs.replaceVars ../dots/hypr/hyprland.conf {
        # kitty = "${pkgs.kitty}";
        # nemo = "${pkgs.nemo}";
        # fuzzel = "${pkgs.fuzzel}";
        # configDirectory = configDirectory;
        # color_fg = color_fg;
        # color_bg2 = color_bg2;
        # color_black = color_black;
        # color_accent = color_accent;
        # color_orange = color_orange;
        # color_bg_diff_green = color_bg_diff_green;
        # color_dim = color_dim;
      });
    };

    # hyprpaper
    services.hyprpaper = {
      enable = true;
      package = hyprpaperPkgs.hyprpaper;
    };
    xdg.configFile."hypr/hyprpaper.conf".text = builtins.readFile (pkgs.replaceVars ../dots/hypr/hyprpaper.conf {
      configDirectory = configDirectory;
    });

  };
}

