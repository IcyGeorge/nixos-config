{ config, pkgs, ... }:
{
  home-manager.users.${config.var.username} = {
    services.mako = {
      enable = true;
      settings = {
        font = "Maple Mono regular 12";
        background-color = "#282828";
        text-color = "#d4be98";
        border-size = 2;
        border-color = "#504945";
        border-radius = 0;
        icons = 0;
        text-alignment = "left";
        default-timeout = 5000;
      };
    };
  };
}
