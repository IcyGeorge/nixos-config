{ config, pkgs, ... }:
{
  home-manager.users.${config.var.username} = {
    programs.qutebrowser = {
      enable = true;
      extraConfig = builtins.readFile ../dots/qutebrowser/config.py;
    };
  };
}
