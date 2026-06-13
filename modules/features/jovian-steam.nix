{ config, pkgs, ... }:
{
  flake.nixosModules.helix = { pkgs, ... }: {
    jovian = {
      steam = {
        enable = true;
        autoStart = true;
        desktopSession = "niri-session";
        user = "gmelika";
      };

      steamos.useSteamOSConfig = true;

      hardware.has.amd.gpu = true;

      decky-loader.enable = true;
    };

    environment.systemPackages = with pkgs; [
      protonplus
      prismlauncher
    ];

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 4000 ];
      allowedUDPPorts = [ 4000 ];
    };
  };
}
