{ config, pkgs, ... }:
{
  jovian = {
    steam = {
      enable = true;
      autoStart = false;
      desktopSession = "sway";
      user = config.var.username;
    };

    steamos.useSteamOSConfig = true;

    hardware.has.amd.gpu = true;

    decky-loader.enable = true;
  };
}

