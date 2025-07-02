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
    
    userThemes = {
        gruvbox = {
          bg        = "#282828";
          fg        = "#ebdbb2";
          red       = "#cc241d";
          green     = "#98971a";
          yellow    = "#d79921";
          blue      = "#458588";
          purple    = "#b16286";
          aqua      = "#689d6a";
          gray      = "#a89984";
          darkGray  = "#3c3836";
          orange    = "#d65d0e";
          bg0_h     = "#1d2021";
  };
    };

    mkHost = hostName: import ./hosts/${hostName} {
      inherit inputs system userSettings userThemes;
    };
  in {
    nixosConfigurations = {
      nixos-desktop = mkHost "nixos-desktop";
      nixos-laptop = mkHost "nixos-laptop";
    };
  };
}

