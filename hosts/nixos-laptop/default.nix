{ inputs, system, userSettings, ... }:

inputs.nixpkgs.lib.nixosSystem rec {
  inherit system;

  modules = [
    ./hardware-configuration.nix
    ./../../modules

    inputs.home-manager.nixosModules.home-manager

    {
      networking.hostName = "nixos-laptop";
      
      networking.networkmanager.enable = true;
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      
      services.getty.autologinUser = "gmelika";
    }
  ];

  specialArgs = {
    inherit userSettings;
  };
}

