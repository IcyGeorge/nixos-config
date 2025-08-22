{ config, inputs, lib, pkgs, ... }:
{
  home-manager.users.${config.var.username} = {
    home.packages = with pkgs; [
      wl-clipboard
    ];

    services.clipse = {
      enable = false;
      historySize = 500;
      allowDuplicates = false;
      theme = {
        "useCustomTheme" = true;
        /* Title bar */
        "TitleFore" = "#d4be98"; # fg
        "TitleBack" = "#282828"; # bg
        "TitleInfo" = "#7daea3"; # blue

        /* Titles */
        "NormalTitle" = "#d3869b"; # purple
        "DimmedTitle" = "#928374"; # gray
        "SelectedTitle" = "#a9b665"; # green

        /* Descriptions */
        "NormalDesc" = "#dfbf8e"; # fg1
        "DimmedDesc" = "#928374"; # gray
        "SelectedDesc" = "#a9b665"; # green

        /* Match & Filter */
        "FilteredMatch" = "#d8a657"; # yellow
        "FilterPrompt" = "#a9b665"; # green
        "FilterInfo" = "#7daea3"; # blue
        "FilterText" = "#d4be98"; # fg
        "FilterCursor" = "#d8a657"; # yellow

        /* Help */
        "HelpKey" = "#928374"; # gray
        "HelpDesc" = "#665c54"; # dark gray

        /* Status & Pins */
        "StatusMsg" = "#a9b665"; # green
        "PinIndicatorColor" = "#ea6962"; # red

        /* Selection Borders */
        "SelectedBorder" = "#7daea3"; # blue
        "SelectedDescBorder" = "#7daea3"; # blue

        /* Pagination */
        "PageActiveDot" = "#7daea3"; # blue
        "PageInactiveDot" = "#665c54"; # bg3
        "DividerDot" = "#504945"; # bg4

        /* Preview */
        "PreviewedText" = "#d4be98"; # fg
        "PreviewBorder" = "#7daea3"; # blue
      };
    };
  };
}
