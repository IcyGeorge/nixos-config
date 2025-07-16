{ config, pkgs, ... }:
{
  home-manager.users.${config.var.username} = {
    programs.fuzzel = {
      enable = true;

      settings = {
        main = {
          font = "MapleMono:size=14";
          prompt = "~ ";
          dpi-aware = false;
          use-bold = false;
          icons-enabled = false;
          inner-pad = 5;
          vertical-pad = 20;
          horizontal-pad = 20;
        };

        border = {
          width = 1;
          radius = 4;
        };

        colors = {
          background = "282828ff"; # bg0
          text = "d4be98ff"; # fg1
          input = "a9b665ff"; # green
          prompt = "a9b665ff"; # green
          match = "d8a657ff"; # yellow
          selection = "34381bff"; # bg_diff_green
          selection-text = "a9b665ff"; # green
          border = "3c3836ff"; # bg1
        };

      };
    };
  };
}

