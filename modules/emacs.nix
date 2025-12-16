{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs-pgtk;
      config = ../dots/emacs/init.el;
      extraEmacsPackages = epkgs: with epkgs; [
      ];
    })
  ];
}
