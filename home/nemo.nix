{config, pkgs, ... }:
let
  user = config.var.username;
  configDirectory = config.var.configDirectory;
in
{
  home.packages = with pkgs; [ nemo ];
  
    # bookmarks for the side pane
  gtk.gtk3.bookmarks = [
    "file:///home/${user}/Downloads Downloads"
    "file:///home/${user}/Pictures Pictures"
    "file://${configDirectory} NixOS"
    # will be added later as part of my dev env
    #"file:///home/${user}/Developement/Android/StudioProjects StudioProjects"
    #"file:///home/${user}/Developement/Godot Godot"
  ];


  dconf.settings = {
    "org/nemo/preferences" = {
      always-use-browser = true;
      # click-double-parent-folder = true;
      close-device-view-on-device-eject = true;
      date-font-choice = "auto-mono";
      date-format = "iso";
      last-server-connect-method = 3;
      quick-renames-with-pause-in-between = true;
      show-edit-icon-toolbar = false;
      show-full-path-titles = false;
      show-hidden-files = true;
      show-home-icon-toolbar = true;
      show-new-folder-icon-toolbar = true;
      show-open-in-terminal-toolbar = false;
      show-show-thumbnails-toolbar = false;
      thumbnail-limit = 10485760;
      default-folder-viewer = "compact-view";
    };
    "org/nemo/preferences/menu-config" = {
      background-menu-open-as-root = false;
      selection-menu-open-as-root = false;
      selection-menu-open-in-terminal = false;
      selection-menu-scripts = false;
    };
    "org/nemo/search" = {
      search-reverse-sort = false;
      search-sort-column = "name";
    };
    "org/nemo/window-state" = {
      maximized = true;
      network-expanded = true;
      side-pane-view = "places";
      sidebar-bookmark-breakpoint = 2;
      sidebar-width = 220;
      start-with-sidebar = true;
    };
    "org/nemo/list-view" = {
      default-visible-columns = [ "name" "size" "date_modified" "owner" "permissions" ];
      use-tree-view = false;
      zoom-level = "small";
};
  };
}
