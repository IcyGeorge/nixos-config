{
  description = "gmelika nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    android-nixpkgs = {
      url = "github:tadfisher/android-nixpkgs/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jovian-nixos.url = "github:Jovian-Experiments/Jovian-NixOS";
  };

  outputs = inputs @ { nixpkgs, ... }: {
    nixosConfigurations = {
      nixos-pc =
        nixpkgs.lib.nixosSystem {
          modules = [
            {
              nixpkgs.overlays = [
                inputs.android-nixpkgs.overlays.default
              ];
              _module.args = { inherit inputs; };
            }
            inputs.home-manager.nixosModules.home-manager
            ./hosts/nixos-pc/configuration.nix
          ];
        };

      nixos-htpc =
        nixpkgs.lib.nixosSystem {
          modules = [
            {
              nixpkgs.overlays = [
                inputs.android-nixpkgs.overlays.default
              ];
              _module.args = { inherit inputs; };
            }
            inputs.home-manager.nixosModules.home-manager
            inputs.jovian-nixos.nixosModules.default
            ./hosts/nixos-htpc/configuration.nix
          ];
        };

      nixos-laptop =
        nixpkgs.lib.nixosSystem {
          modules = [
            {
              nixpkgs.overlays = [
                inputs.android-nixpkgs.overlays.default
              ];
              _module.args = { inherit inputs; };
            }
            inputs.home-manager.nixosModules.home-manager
            ./hosts/nixos-laptop/configuration.nix
          ];
        };
    };
  };
}
