{ config, pkgs, ... }:
{
  home-manager.users.${config.var.username} = {
    programs.fuzzel = {
      enable = true;
    };
    xdg.configFile = {
      "fuzzel/fuzzel.ini".source = ../dots/fuzzel/fuzzel.ini;
    };
  };
}

