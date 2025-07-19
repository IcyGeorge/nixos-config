{ config, pkgs, ... }:
{
  #programs.kitty.enable = true; # required for the default Hyprland config
  home-manager.users.${config.var.username} = {
    programs.kitty = {
      enable = true;
          themeFile = "GruvboxMaterialDarkMedium";
    font = {
      name = "Maple Mono";
      size = 14;
    };

    };
  };
}
