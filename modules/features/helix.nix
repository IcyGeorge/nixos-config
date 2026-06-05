{ config, pkgs, ... }:
{
  flake.nixosModules.helix = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.helix ];

    hjem.users.gmelika = {
      files = {
        ".config/helix/config.toml".source = ../../dots/helix/config.toml;
        ".config/helix/languages.toml".source = ../../dots/helix/languages.toml;
      };
    };
  };
}
