{ config, inputs, pkgs, ... }:
{
  home-manager.users.${config.var.username} = {
    services.hyprpaper = {
      enable = true;
      package = inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.hyprpaper;
    };
    xdg.configFile."hypr/hyprpaper.conf".text = builtins.readFile (pkgs.replaceVars ../dots/hypr/hyprpaper.conf {
      configDirectory = config.var.configDirectory;
    });

  };
}
