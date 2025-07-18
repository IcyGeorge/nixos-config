{ config, ... }: {
  imports = [
    #../../modules/android-dev.nix
    #../../modules/ruby.nix
    ../../modules/slack.nix
    ../../modules/zoom-us.nix
    ../../modules/hardware.nix
    ../../modules/nix-ld.nix
    ../../modules/audio.nix
    ../../modules/bluetooth.nix
    ../../modules/fonts.nix
    ../../modules/foot.nix
    ../../modules/fuzzel.nix
    ../../modules/fish.nix
    ../../modules/git.nix
    ../../modules/gnome.nix
    ../../modules/gtk.nix
    ../../modules/home-manager.nix
    ../../modules/lazygit.nix
    ../../modules/mako.nix
    ../../modules/nemo.nix
    ../../modules/nix.nix
    ../../modules/sddm.nix
    ../../modules/spicetify.nix
    ../../modules/systemd-boot.nix
    ../../modules/sway.nix
    ../../modules/users.nix
    ../../modules/utils.nix
    ../../modules/waybar.nix
    ../../modules/xdg.nix
    ../../modules/zen.nix


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
