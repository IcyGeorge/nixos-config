{ config, pkgs, ... }:
{
  home-manager.users.${config.var.username} = {
    home.packages = with pkgs; [
      waybar
    ];

    programs.waybar = {
      enable = true;
      systemd.enable = true;
    };

    xdg.configFile = {
      "waybar/config.jsonc".source = ../dots/waybar/config.jsonc;
      "waybar/style.css".source = ../dots/waybar/style.css;
    };
  };
}
