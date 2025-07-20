{ inputs, pkgs, ... }:
let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  #boot.initrd.kernelModules = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
    package = pkgs-unstable.mesa;
    # if you also want 32-bit support (e.g for Steam)
    enable32Bit = true;
    package32 = pkgs-unstable.pkgsi686Linux.mesa;
    extraPackages = with pkgs; [
      intel-media-driver
      (vaapiIntel.override { enableHybridCodec = true; })
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [
    vulkan-tools
    vulkan-loader
    #amdvlk
  ];

  environment.variables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "va_gl";
    NIXOS_OZONE_WL = "1";
  };
}

