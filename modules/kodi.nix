{ config, pkgs, ... }: {

  home-manager.users.${config.var.username} = {
    programs.kodi = {
      enable = true;
      package = pkgs.kodi.withPackages (k-pkgs: [
        k-pkgs.joystick
        k-pkgs.pvr-iptvsimple
      ]);
    };
  };

  networking.firewall.enable = true;
  networking.firewall = {
    allowedTCPPorts = [ 8081 ];
    allowedUDPPorts = [ 8081 ];
  };

  users.users.${config.var.username}.extraGroups = [ "video" ];

}
