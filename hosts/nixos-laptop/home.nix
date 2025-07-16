{ pkgs
, config
, ...
}: {
  imports = [
    # Mostly user-specific configuration
    ./variables.nix

    # Programs
    #../../home/alacritty.nix







    # System (Desktop environment like stuff)



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
