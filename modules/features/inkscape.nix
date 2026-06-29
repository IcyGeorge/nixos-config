{ config, pkgs, ... }:
{
  flake.nixosModules.inkscape = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.inkscape ];
  };
}
