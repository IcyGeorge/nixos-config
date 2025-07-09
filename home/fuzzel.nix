{ pkgs, ... }:
{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = "MapleMono:size=12";
        prompt = "";
        dpi-aware = false;
        use-bold = false;
        icons-enabled = false;
        inner-pad = 5;
        vertical-pad = 20;
        horizontal-pad = 20;
      };

      border = {
        width = 0;
        radius = 0;
      };

      colors = {
        background = "282828ff";
        text = "d4be98ff";
        match = "d8a657ff";
        selection = "32302fff";
        selection-text = "d4be98ff";
        border = "3c3836ff";
      };
    };
  };
}

