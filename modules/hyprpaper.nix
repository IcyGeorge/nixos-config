{ config, pkgs, ... }:
{
  home-manager.users.${config.var.username} = {
    services.hyprpaper = {
      enable = true;
      package = pkgs.hyprpaper;
      settings = {
        splash = true;
        ipc = true;
        preload = [
          "${config.var.configDirectory}/assets/wallpapers/wallpaper.jpg"
        ];
        wallpaper = [
          "${config.var.configDirectory}/assets/wallpapers/wallpaper.jpg"
        ];
      };
    };
  };
}
