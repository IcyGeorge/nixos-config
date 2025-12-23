{ config, pkgs, ... }:
let
  configDirectory = config.var.configDirectory;
in
{
  services.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.paperwm
    gnomeExtensions.auto-accent-colour
  ];

  environment.gnome.excludePackages = (with pkgs; [
    # atomix # puzzle game
    # cheese # webcam tool
    epiphany # web browser
    # evince # document viewer
    # geary # email reader
    # gedit # text editor
    # gnome-characters
    # gnome-music
    # gnome-photos
    # gnome-terminal
    # gnome-tour
    # hitori # sudoku game
    # iagno # go game
    # tali # poker game
    # totem # video player
  ]);

  home-manager.users.${config.var.username} = {
    home.packages = (with pkgs; [
      dconf-editor
    ]);


    dconf.settings = {
      "org/gnome/desktop/interface" = {
        accent-color = "green";
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu";
      };

      "org/gnome/desktop/background" = {
        picture-uri = "${configDirectory}/assets/wallpapers/wallpaper.jpg";
        picture-uri-dark = "${configDirectory}/assets/wallpapers/wallpaper.jpg";
      };

      "org/gnome/desktop/interface".clock-format = "12h";
      "org/gtk/settings/file-chooser".clock-format = "12h";

      "org/gnome/TextEditor" = {
        custom-font = "Maple Mono NF 14";
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

      "org/gnome/nautilus/preferences".default-folder-viewer = "list-view";
      "org/gtk/gtk4/settings/file-chooser".show-hidden = true;

      "org/gnome/mutter" = {
        experimental-features = [
          "scale-monitor-framebuffer" # Enables fractional scaling (125% 150% 175%)
          "variable-refresh-rate" # Enables Variable Refresh Rate (VRR) on compatible displays
          "xwayland-native-scaling" # Scales Xwayland applications to look crisp on HiDPI screens
        ];
      };
      "org/gnome/shell" = {
        enabled-extensions = [
          pkgs.gnomeExtensions.blur-my-shell.extensionUuid
          pkgs.gnomeExtensions.paperwm.extensionUuid
        ];

        "app-switcher/current-workspace-only" = true;
      };

      "org/gnome/shell/extensions/paperwm" = {
        selection-border-szie = 4;
        selection-border-radius-bottom = 0;
        selection-border-radius-top = 0;
        window-gap = 8;
        horizontal-margin = 8;
        vertical-margin = 8;
        vertical-margin-bottom = 8;

        show-window-position-bar = false;
        show-workspace-indicator = false;

        winprops = [
          ''{"wm_class":"zoom","scratch_layer":true}''
        ];
      };
      "org/gnome/shell/extensions/paperwm/keybindings" = {
        switch-left = [ "<Super>h" ];
        switch-right = [ "<Super>l" ];
        switch-up = [ "<Super>k" ];
        switch-down = [ "<Super>j" ];

        move-left = [ "<Super><Shift>h" ];
        move-right = [ "<Super><Shift>l" ];
        move-up = [ "<Super><Shift>k" ];
        move-down = [ "<Super><Shift>j" ];

        close-window = [ "<Super>q" ];
        new-window = [ "<Super><Shift>Return" ];
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>Return";
        command = "kitty";
        name = "open-terminal";
      };
    };
  };
}
