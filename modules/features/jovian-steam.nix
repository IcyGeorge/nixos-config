{ inputs, pkgs, lib, ... }:
{
  flake.nixosModules.jovianSteam = { pkgs, lib, ... }: {
    imports = [
      inputs.jovian.nixosModules.default
    ];
    jovian = {
      steam = {
        enable = true;
        autoStart = lib.mkDefault true;
        desktopSession = "niri";
        user = "gmelika";
      };

      steamos.useSteamOSConfig = lib.mkDefault true;

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
