{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;

    settings = {
      colors = {
        primary = {
          background = "#282828";
          foreground = "#d4be98";
        };

        normal = {
          black   = "#3c3836";
          red     = "#ea6962";
          green   = "#a9b665";
          yellow  = "#d8a657";
          blue    = "#7daea3";
          magenta = "#d3869b";
          cyan    = "#89b482";
          white   = "#d4be98";
        };

        bright = {
          black   = "#3c3836";
          red     = "#ea6962";
          green   = "#a9b665";
          yellow  = "#d8a657";
          blue    = "#7daea3";
          magenta = "#d3869b";
          cyan    = "#89b482";
          white   = "#d4be98";
        };
      };

      font = {
        size = 14;

        normal = {
          family = "Maple Mono";
          #style = "Medium";
        };
      };

      #terminal.shell = {
        #program = "/bin/fish";
      #};

      window = {
        opacity = 0.75;
        padding = {
          x = 5;
          y = 5;
        };
      };
    };
  };
}
