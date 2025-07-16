{ config, lib, ... }:
let
  accent = "#a9b665";
  accentBg = "#34381b";
  muted = "#45403d";
in
{
  home-manager.users.${config.var.username} = {
    programs.lazygit = {
      enable = true;
      settings = lib.mkForce {
        disableStartupPopups = true;
        notARepository = "skip";
        promptToReturnFromSubprocess = false;
        update.method = "never";
        git = {
          commit.signOff = true;
          parseEmoji = true;
        };
        gui = {
          theme = {
            activeBorderColor = [ accent "bold" ];
            inactiveBorderColor = [ muted ];
            selectedLineBgColor = [ accentBg ];
          };
          nerdFontsVersion = "3";
        };
      };
    };
  };
}
