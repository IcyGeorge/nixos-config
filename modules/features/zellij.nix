{ config, pkgs, ... }:
{
  flake.nixosModules.zellij = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.zellij
    ];

    hjem.users.gmelika.files = {
      ".config/zellij/config.kdl".source =
        ../../dots/.config/zellij/config.kdl;

      ".config/zellij/themes/gruvbox-material-dark.kdl".source =
        ../../dots/.config/zellij/themes/gruvbox-material-dark.kdl;
    };
  };
}
