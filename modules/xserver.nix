{ config, lib, pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      excludePackages = [ pkgs.xterm ];
      displayManager.lightdm.enable = lib.mkForce false;
    };

    displayManager = {
      sddm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = config.var.username;
      defaultSession = "niri";
    };
    libinput = {
      enable = true;
    };
  };
  # To prevent getting stuck at shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}
