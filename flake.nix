{
  description = "gmelika nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    sops-nix.url = "github:Mic92/sops-nix";
    anyrun.url = "github:fufexan/anyrun/launch-prefix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    search-nixos-api.url = "github:anotherhadi/search-nixos-api";
    android-nixpkgs = {
      url = "github:tadfisher/android-nixpkgs/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.nixpkgs.follows = "hyprland/nixpkgs";
    };
  };

  outputs = inputs @ { nixpkgs, ... }: {
    nixosConfigurations = {
      nixos-pc =
        nixpkgs.lib.nixosSystem {
          modules = [
            {
              nixpkgs.overlays = [
                inputs.niri.overlays.niri
                inputs.hyprpaper.overlays.default
                inputs.android-nixpkgs.overlays.default
              ];
              _module.args = { inherit inputs; };
            }
            inputs.home-manager.nixosModules.home-manager
            inputs.niri.nixosModules.niri
            ./hosts/nixos-pc/configuration.nix
          ];
        };

      nixos-laptop =
        nixpkgs.lib.nixosSystem {
          modules = [
            {
              nixpkgs.overlays = [
                inputs.niri.overlays.niri
                inputs.hyprpaper.overlays.default
                inputs.android-nixpkgs.overlays.default
              ];
              _module.args = { inherit inputs; };
            }
            inputs.niri.nixosModules.niri
            inputs.home-manager.nixosModules.home-manager
            ./hosts/nixos-laptop/configuration.nix
          ];
        };
    };
  };
}
