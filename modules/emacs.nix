{ config, pkgs, ... }:
let
  user = config.var.username;
in
{
  environment.systemPackages = with pkgs; [
    emacs-pgtk
    # required dependencies
    git
    emacs # Emacs 27.2
    ripgrep
    # optional dependencies
    coreutils # basic GNU utilities
    fd
    clang
  ];

  # TODO: add init.el to /dots/emacs
  environment.shellInit = ''
    export PATH="$PATH:$HOME/.emacs.d/bin"
  '';
}
