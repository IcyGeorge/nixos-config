{ config, lib, pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      excludePackages = [ pkgs.xterm ];
      displayManager.lightdm.enable = lib.mkForce false;
    };
    libinput = {
      enable = true;
    };
  };
  # To prevent getting stuck at shutdown
  systemd.services.NetworkManager.serviceConfig.TimeoutStopSec = "15s";
}
