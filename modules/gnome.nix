{ config, pkgs, ... }:
{
  home-manager.users.${config.var.username} = {
    home.packages = (
      with pkgs;
      [
        loupe # image viewer
        evince # pdf
        file-roller # archive
        gnome-text-editor # gedit
      ]
    );

    dconf.settings = {
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu";
      };
      "org/gnome/TextEditor" = {
        custom-font = "Maple Mono 14";
        highlight-current-line = true;
        indent-style = "space";
        restore-session = false;
        show-grid = false;
        show-line-numbers = true;
        show-right-margin = false;
        style-scheme = "builder-dark";
        style-variant = "dark";
        tab-width = "uint32 4";
        use-system-font = false;
        wrap-text = false;
      };
    };
  };
}
