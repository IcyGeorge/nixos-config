{ config, pkgs, ... }:
{
  programs.fish.enable = true;
  home-manager.users.${config.var.username} = {
    programs.fish.enable = true;
  };
}
