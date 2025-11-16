{ config, pkgs, ... }:
{
  jovian = {
    steam = {
      enable = true;
      autoStart = config.var.htpcMode;
      desktopSession = "sway-uwsm";
      user = config.var.username;
    };

    steamos.useSteamOSConfig = true;

    hardware.has.amd.gpu = true;

    decky-loader.enable = true;
  };

  environment.systemPackages = [ pkgs.lutris pkgs.prismlauncher ];

  networking.firewall.enable = true;
  networking.firewall = {
    allowedTCPPorts = [ 4000 ];
    allowedUDPPorts = [ 4000 ];
  };
}

