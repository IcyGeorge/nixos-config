{
  flake.nixosModules.androidStudio = { inputs, pkgs, ... }:
    let
      sdkPath =
        "/home/gmelika"
        + "/Android/Sdk"; # why? because android studio sucks!! 
    in
    {
      nixpkgs.config.android_sdk.accept_license = true;

      environment.systemPackages = with pkgs; [
        devbox
        gradle
        jdk17
        qemu_kvm
        libX11
        android-tools
        (android-studio.override { forceWayland = true; })
        mitmproxy
      ];


      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
      };

      # services.udev.packages = [ pkgs.android-udev-rules ];

      virtualisation.libvirtd.enable = true;

      users.users.gmelika.extraGroups = [ "adbusers" "kvm" "libvirtd" "video" ];

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

      programs.nix-ld.enable = true;
      programs.nix-ld.libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
      ];

    };
}
