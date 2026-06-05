{ config, pkgs, ... }:
{
  flake.nixosModules.keyd = { pkgs, lib, ... }: {
    services.keyd = {
      enable = true;

      keyboards.default = {
        ids = [ "*" ];

        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };
}

