{pkgs, ...}: {
  # Video Drivers
  hardware = {
    amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
    };
    graphics = {
      enable = true;
      # if you also want 32-bit support (e.g for Steam)
      enable32Bit = true;
      extraPackages = with pkgs; [
        #vaapiVdpau
        libvdpau-va-gl
        rocmPackages.clr.icd # AMD required pkg
        libva
        libva-utils
        vulkan-tools
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        #vaapiVdpau
        libvdpau-va-gl
        libva
        # rocmPackages.clr.icd # AMD required pkg
      ];
    };
  };
  # GPU Settings RX 7800XT & 9070XT
  boot.kernelModules = ["amdgpu"];
  hardware.enableRedistributableFirmware = true;
  environment.systemPackages = with pkgs; [
    rocmPackages.clr.icd
  ];
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
  # nixpkgs.config.rocmSupport = true;
   environment.variables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    AMD_VULKAN_ICD = "RADV";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
  };
}
