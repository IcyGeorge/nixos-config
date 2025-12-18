{ pkgs, ... }:

{
  services.keyd = {
    enable = true;

    keyboards.default = {
      ids = [ "*" ];

      settings = {
        main = {
          capslock = "overload(control, esc)";
        };
      };
    };
  };

  environment.systemPackages = [
    (pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs-pgtk;
      config = ../dots/emacs/init.el;
      defaultInitFile = true;
      alwaysEnsure = true;
      extraEmacsPackages = epkgs: with epkgs; [
        ivy
        ivy-rich
        helpful
        swiper

        nerd-icons
        doom-modeline
        doom-themes

        general
        evil
        evil-collection
        projectile
      ];
    })
  ];
}
