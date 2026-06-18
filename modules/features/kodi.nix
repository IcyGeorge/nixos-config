{ config, pkgs, ... }:
{
  flake.nixosModules.kodi = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.kodi ];
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        8080
        9090
      ];

      allowedUDPPorts = [
        9777
      ];

    };

  };
}
