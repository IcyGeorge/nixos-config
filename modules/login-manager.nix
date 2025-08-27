{ config, pkgs, ... }:
{
  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors = {
    sway = {
      prettyName = "Sway";
      comment = "Sway compositor managed by UWSM";
      binPath = "${pkgs.sway}/bin/sway";
    };
  };
}
