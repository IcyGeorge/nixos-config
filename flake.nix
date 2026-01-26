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
      url = "github:tadfisher/android-nixpkgs/5bfe4af6e619e5f612809d7b6ec702b601ee4851";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jovian-nixos.url = "github:Jovian-Experiments/Jovian-NixOS/development";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixCats.url = "github:IcyGeorge/nixCats";
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
            inputs.nixCats.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
            inputs.jovian-nixos.nixosModules.default
            inputs.nixos-hardware.nixosModules.common-pc
            inputs.nixos-hardware.nixosModules.common-pc-ssd
            inputs.nixos-hardware.nixosModules.common-hidpi
            inputs.nixos-hardware.nixosModules.common-gpu-amd
            inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
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
            inputs.nixCats.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
            inputs.jovian-nixos.nixosModules.default
            inputs.nixos-hardware.nixosModules.common-pc
            inputs.nixos-hardware.nixosModules.common-pc-ssd
            inputs.nixos-hardware.nixosModules.common-hidpi
            inputs.nixos-hardware.nixosModules.common-gpu-amd
            inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
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
            inputs.nixCats.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
            inputs.jovian-nixos.nixosModules.default
			inputs.nixos-hardware.nixosModules.common-pc
            inputs.nixos-hardware.nixosModules.common-pc-ssd
            inputs.nixos-hardware.nixosModules.common-hidpi

            ./hosts/nixos-laptop/configuration.nix
          ];
        };
    };
  };
}
