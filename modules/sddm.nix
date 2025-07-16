# SDDM is a display manager for X11 and Wayland
{ pkgs, inputs, config, lib, ... }:
let
  foreground = config.theme.textColorOnWallpaper;
  sddm-astronaut = pkgs.sddm-astronaut;
in
{
  services.displayManager = {
    sddm = {
      package = pkgs.kdePackages.sddm;
      extraPackages = [ sddm-astronaut ];
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
    };
  };

  environment.systemPackages = [ sddm-astronaut ];

  # To prevent getting stuck at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}
