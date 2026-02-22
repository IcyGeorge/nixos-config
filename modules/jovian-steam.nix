{ config, pkgs, ... }:
{
  jovian = {
    steam = {
      enable = true;
      autoStart = config.var.htpcMode;
      desktopSession = "gnome";
      user = config.var.username;
    };

    steamos.useSteamOSConfig = true;

    hardware.has.amd.gpu = true;

    decky-loader.enable = true;
  };

  environment.systemPackages = with pkgs; [
    lutris
    protonplus
    prismlauncher
    ludusavi
    rclone
  ];

  networking.firewall.enable = true;
  networking.firewall = {
    allowedTCPPorts = [ 4000 ];
    allowedUDPPorts = [ 4000 ];
  };
}

