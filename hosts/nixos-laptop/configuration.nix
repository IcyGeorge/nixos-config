{ config, ... }: {
  imports = [
    ../../modules/audio.nix
    ../../modules/bluetooth.nix
    ../../modules/dev.nix
    ../../modules/firefox.nix
    ../../modules/fish.nix
    ../../modules/fonts.nix
    ../../modules/git.nix
    ../../modules/gnome.nix
    ../../modules/gtk.nix
    ../../modules/home-manager.nix
    ../../modules/kitty.nix
    ../../modules/kodi.nix
    ../../modules/keyd.nix
    ../../modules/lazygit.nix
    ../../modules/login-manager.nix
    ../../modules/jovian-steam.nix
    ../../modules/neovim.nix
    ../../modules/nix-ld.nix
    ../../modules/nix.nix
    ../../modules/qutebrowser.nix
    ../../modules/spicetify.nix
    ../../modules/starship.nix
    ../../modules/systemd-boot.nix
    ../../modules/users.nix
    ../../modules/utils.nix
    ../../modules/xserver.nix

    # You should let those lines as is
    ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = {
    home = {
      inherit (config.var) username;
      homeDirectory = "/home/" + config.var.username;

      # Don't touch this
      stateVersion = "25.05";
    };
    programs.home-manager.enable = true;
  };



  # Don't touch this
  system.stateVersion = "25.05";
}
