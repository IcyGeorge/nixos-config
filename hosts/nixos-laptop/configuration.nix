{ config, ... }: {
  imports = [
    ../../modules/mako.nix
    ../../modules/xdg-mime.nix
    ../../modules/fuzzel.nix
    ../../modules/foot.nix
    ../../modules/git.nix
    ../../modules/nemo.nix
    ../../modules/lazygit.nix
    ../../modules/spicetify.nix
    ../../modules/zen.nix
    ../../modules/gnome.nix
    #../../modules/niri.nix
    ../../modules/sway.nix
    ../../modules/waybar.nix

    ../../modules/audio.nix
    ../../modules/bluetooth.nix
    ../../modules/fonts.nix
    ../../modules/home-manager.nix
    ../../modules/nix.nix
    ../../modules/systemd-boot.nix
    ../../modules/sddm.nix
    ../../modules/users.nix
    ../../modules/utils.nix
    ../../modules/gtk.nix

    ../../dev/android-dev.nix

    # You should let those lines as is
    ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  # Don't touch this
  system.stateVersion = "25.05";
}
