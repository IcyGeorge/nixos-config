{ inputs, pkgs, ... }:
{
  flake.nixosModules.jovianSteam = { pkgs, ... }: {
    imports = [
      inputs.jovian.nixosModules.default
    ];
    jovian = {
      steam = {
        enable = true;
        autoStart = true;
        desktopSession = "niri";
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
