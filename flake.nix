{
  description = "NixOS config with flakes, home-manager, and sway";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: let
    system = "x86_64-linux";

    userSettings = {
      username = "gmelika";
      fullName = "George Melika";
      timezone = "Africa/Cairo";
      email = "georgenaiem1@gmail.com";
    };

    mkHost = hostName: import ./hosts/${hostName} {
      inherit inputs system userSettings;
    };
  in {
    nixosConfigurations = {
      nixos-desktop = mkHost "nixos-desktop";
      nixos-laptop = mkHost "nixos-laptop";
    };
  };
}

