{ config, pkgs, ... }:
{
  home-manager.users.${config.var.username} = {
    gtk = {
      enable = true;
      font = {
        name = "Maple Mono NF";
        size = 14;
      };
      theme = {
        name = "Gruvbox-Green-Dark-Compact-Medium";
        package = pkgs.gruvbox-gtk-theme.override {
          colorVariants = [ "dark" ];
          themeVariants = [ "green" ];
          sizeVariants = [ "compact" ];
          tweakVariants = [
            "medium"
            "float"
          ];
        };
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme.override { color = "black"; };
      };
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
      };
      gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };
      gtk4.extraConfig = { gtk-application-prefer-dark-theme = true; };
    };

    home.pointerCursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
