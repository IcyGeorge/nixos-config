{ config, pkgs, ... }:
{
  #programs.kitty.enable = true; # required for the default Hyprland config
  home-manager.users.${config.var.username} = {
    programs.kitty = {
      enable = true;
      themeFile = "GruvboxMaterialDarkMedium";
      font = {
        name = "JetBrainsMono NF";
        size = 14;
      };


      settings = {
        ## Opacity & blur
        background_opacity = "1";
        background_blur = "0";

        ## Window settings
        window_border_width = "1";
        draw_minimal_borders = "yes";
        window_padding_width = "0 4 0";
        placement_strategy = "center";
        hide_window_decorations = "yes";

        ## Cursor
        cursor_text_color = "background";
        cursor_shape = "block";
        cursor_beam_thickness = "1.5";
        cursor_underline_thickness = "4.0";
        cursor_blink_interval = "0.6";
        cursor_stop_blinking_after = "10.0";

        ## Misc
        enable_audio_bell = "no";
        shell_integration = "enabled";
        sync_to_monitor = "yes";
      };

    };
  };
}
