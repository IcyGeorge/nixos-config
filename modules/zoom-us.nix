{ config, pkgs, ... }:
let
  user = config.var.username;
in
{
  home-manager.users.${user} = {
    home.packages = with pkgs; [ zoom-us ];
  };
}
