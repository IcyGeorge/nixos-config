{ config, pkgs, ... }:
{
  jovian = {
    steam = {
      enable = true;
      autoStart = config.var.htpcMode;
      desktopSession = "hyprland-uwsm";
      user = config.var.username;
    };

    steamos.useSteamOSConfig = true;

    hardware.has.amd.gpu = true;

    decky-loader.enable = true;
  };
}

