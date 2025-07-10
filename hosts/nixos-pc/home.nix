{
  pkgs,
  config,
  ...
}: {
  imports = [
    # Mostly user-specific configuration
    ./variables.nix

    # Programs
    #../../home/alacritty.nix
    ../../home/foot.nix
    ../../home/git.nix
    ../../home/nemo.nix
    ../../home/zen.nix
    ../../home/gnome.nix
    ../../home/lazygit.nix


    # System (Desktop environment like stuff)
    ../../home/niri.nix
    ../../home/waybar.nix
    ../../home/fuzzel.nix
    ../../home/mako.nix
    ../../home/gtk.nix
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    packages = with pkgs; [
      zip
      unzip
    ];

    # Don't touch this
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
