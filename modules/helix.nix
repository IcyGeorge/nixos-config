{ config, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.helix ];

  home-manager.users.${config.var.username} = {
    home.packages = with pkgs; [
      nixpkgs-fmt
      rust-analyzer
      nixd
    ];

    programs.helix = {
      enable = true;
      defaultEditor = true;
    };
    
    xdg.configFile."helix/config.toml".text = builtins.readFile ../dots/helix/config.toml;
    xdg.configFile."helix/languages.toml".text = builtins.readFile ../dots/helix/languages.toml;
  };

}
