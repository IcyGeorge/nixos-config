{ config, pkgs, ... }:
{
  flake.nixosModules.aseprite = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.aseprite ];
  };
}
