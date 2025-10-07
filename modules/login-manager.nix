{ config, lib, pkgs, ... }:
{
  config = lib.mkIf (!config.var.htpcMode) {
    services.displayManager = {
      sddm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = config.var.username;
      defaultSession = "sway-uwsm";
    };
  };
}
