{ config, pkgs, ... }:
let
  configDirectory = config.var.configDirectory;
in
{
  home-manager.users.${config.var.username} = {
    programs.qutebrowser = {
      enable = true;
      extraConfig = builtins.readFile (pkgs.replaceVars ../dots/qutebrowser/config.py {
        configDirectory = configDirectory;
      });

    };
  };
}
