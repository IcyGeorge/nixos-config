{ config, ... }:
let
  username = config.var.git.username;
  email = config.var.git.email;
in
{
  home-manager.users.${config.var.username} = {
    programs.git = {
      enable = true;
      ignores = [
        ".cache/"
        ".DS_Store"
        ".idea/"
        "*.swp"
        "*.elc"
        "auto-save-list"
        ".direnv/"
        "node_modules"
        "result"
        "result-*"
      ];
      settings = {
        user.name = username;
        user.email = email;
        init.defaultBranch = "main";
        pull.rebase = "false";
        push.autoSetupRemote = true;
        color.ui = "1";
      };
    };
  };
}
