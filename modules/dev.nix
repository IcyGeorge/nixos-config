{ config, inputs, pkgs, ... }:
let
  sdkPath =
    "/home/"
    + config.var.username
    + "/Android/Sdk"; # why? because android studio sucks!! 

in
{
  home-manager.users.${config.var.username} = {

    imports = [
      inputs.android-nixpkgs.hmModule
      {
        android-sdk = {
          enable = true;
          path = sdkPath;
          packages = sdk: with sdk; [
            cmdline-tools-latest
            platform-tools
            #add-ons-addon-google-apis-google-24
            build-tools-35-0-0
            platforms-android-35
            sources-android-35
            emulator
            #system-images-android-36-google-apis-x86-64 -> if you don't need playstore 
            system-images-android-36-google-apis-playstore-x86-64
            system-images-android-29-google-apis-playstore-x86
          ];
        };
      }
    ];
    home.packages = with pkgs; [
      devbox
      gradle
      jdk17
      qemu_kvm
      xorg.libX11
      (android-studio.override { forceWayland = true; })
      mitmproxy
    ];
  };


  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.adb.enable = true;

  services.udev.packages = [ pkgs.android-udev-rules ];

  virtualisation.libvirtd.enable = true;

  users.users.${config.var.username}.extraGroups = [ "adbusers" "kvm" "libvirtd" "video" ];

  networking.firewall.enable = true;
  networking.firewall = {
    allowedTCPPorts = [ 5555 ];
    allowedUDPPorts = [ 5555 ];
  };

  environment.variables = {
    ANDROID_HOME = sdkPath; # Primary as per docs
    ANDROID_SDK_ROOT = sdkPath; # Kept for compatibility
    GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=$ANDROID_HOME/build-tools/35.0.0/aapt2";
    JAVA_HOME = pkgs.jdk17.home;
    _JAVA_AWT_WM_NONREPARENTING = "1";

    # assuming that you have programs.adb.enable = true; and  ["kvm" "adbusers"] groups added
    # emulator related: vulkan-loader and libGL shared libs are necessary for hardware decoding

    # needed to enable emualator hardware acceleration. not sure if there is a better
    # way to do it but works fine on my end. change this if you don't have an AMD gpu.
    # sometimes i need to manually enable the emulator hardware acceleration from
    # android studio.
    #LIBVA_DRIVER_NAME = "radeonsi";
    #AMD_VULKAN_ICD = "RADV";
    #VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/radeon_icd.i686.json";
  };

  environment.shellInit = ''
    export PATH="$PATH:$HOME/.pub-cache/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"
  '';
}
