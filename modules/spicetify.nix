{ config, inputs, pkgs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  home-manager.users.${config.var.username} = {
    imports = [ inputs.spicetify-nix.homeManagerModules.default ];
    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.onepunch;
      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        historyShortcut
        hidePodcasts
        keyboardShortcut
      ];
    };
  };
}

