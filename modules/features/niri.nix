{
  flake.nixosModules.niri = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      wl-clipboard
      wtype
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      xwayland-satellite

      grim
      slurp
      swappy
      wf-recorder
      brightnessctl
      warpd

      adw-gtk3
      gnome-themes-extra
      papirus-icon-theme
      bibata-cursors
    ];

    programs.niri.enable = true;
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;

    xdg.portal.config = {
      common = {
        default = [
          "gtk"
          "gnome"
        ];
      };
    };

    programs.dconf.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    hjem.users.gmelika = {
      files = {
        ".config/niri/config.kdl".source = ../../dots/.config/niri/config.kdl;
      };
    };

  };
}
