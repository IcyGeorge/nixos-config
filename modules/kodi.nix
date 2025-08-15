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

  users.users.${config.var.username}.extraGroups = [ "video" ];
}
