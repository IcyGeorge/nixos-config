{ config, pkgs, ... }:
{
  home-manager.users.${config.var.username} = {
    programs.waybar = {
      enable = true;
      # systemd.enable = true;
    };

    xdg.configFile = {
      "waybar/config.jsonc".source = ../dots/waybar/config.jsonc;
      "waybar/style.css".source = ../dots/waybar/style.css;
    };
  };
}
