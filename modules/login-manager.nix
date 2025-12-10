{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (!config.var.htpcMode) {
    services.displayManager = {
      gdm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = config.var.username;
      defaultSession = "gnome";
    };
  };
}
