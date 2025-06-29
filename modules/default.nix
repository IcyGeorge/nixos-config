{ home-manager, lib, userSettings, ... }:

let
  username = userSettings.username;
  timezone = userSettings.timezone;
in {
  imports = [
    ./git.nix
    ./sway.nix
    ./user.nix
    ./nemo.nix
    ./emacs.nix
    ./firefox.nix
    ./ssh.nix
  ];
  
  
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    # See here what bumping this value impacts: https://nix-community.github.io/home-manager/release-notes.xhtml
    users.${userSettings.username}.home. stateVersion = "25.05";
  };

  system.stateVersion = "25.05";
}

