{ config, pkgs, ... }:
{
  home-manager.users.${config.var.username} = {
    home.packages = with pkgs; [
      starship
    ];

    xdg.configFile."starship.toml".source = ./../dots/starship/starship.toml;

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
