{ config, inputs, ... }:
let autoGarbageCollector = config.var.autoGarbageCollector;
in {
  security.sudo.extraRules = [{
    users = [ config.var.username ];
    commands = [{
      command = "/run/current-system/sw/bin/nixos-rebuild";
      options = [ "NOPASSWD" ];
    }];
  }];
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    android_sdk.accept_license = true;
  };
  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    #channel.enable = false;
    extraOptions = ''
      warn-dirty = false
    '';
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        # high priority since it's almost always used
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
        "https://numtide.cachix.org"
        "https://hyprland.cachix.org"
        "https://niri.cachix.org"

      ];
      trusted-substituters = [
        # high priority since it's almost always used
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
        "https://numtide.cachix.org"
        "https://hyprland.cachix.org"
        "https://niri.cachix.org"

      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
    };
    gc = {
      automatic = autoGarbageCollector;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
