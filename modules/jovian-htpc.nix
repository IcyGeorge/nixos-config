{ config, pkgs, ... }: {
  jovian.steam.enable = true;
  jovian.steam.autoStart = true;
  jovian.steam.desktopSession = "niri";
  jovian.hardware.has.amd.gpu = true;
}
