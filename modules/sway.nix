{ config, pkgs, ... }:

let
  configDirectory = config.var.configDirectory;

  color_fg = "#d4be98"; # foreground
  color_bg2 = "#3c3836"; # slightly lighter bg
  color_black = "#1d2021"; # dark gray/black
  color_accent = "#a9b665"; # green accent
  color_orange = "#e78a4e"; # yellow (used for urgent)
  color_bg_diff_green = "#32361a"; # diff add background (green)
  color_dim = "#1b1b1b"; # dim background (dark)

  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-enviroment";
    executable = true;

    text = ''
      dbus-update-activation-enviroment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure/-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsetting-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'WhiteSur-dark'
        gsettings set $gnome_schema cursor-theme 'capitaine-cursors-white'
      '';
  };


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
    SDL_VIDEODRIVER = "wayland,x11";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "sway";
  };
  environment.systemPackages = with pkgs; [
    sway
    dbus-sway-environment
    configure-gtk
    wayland
    wl-clipboard

    # https://github.com/Jovian-Experiments/Jovian-NixOS/issues/267
    (writers.writeDashBin "sway-logout" ''
      ${systemd}/bin/systemctl --user unset-environment WAYLAND_DISPLAY SWAYSOCK
      ${sway}/bin/swaymsg exit
    '')
  ];

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

