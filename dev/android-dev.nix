{
  config,
  inputs,
  pkgs,
  ...
}:
let
   username = config.var.username;
   androidSdk = inputs.android-nixpkgs.sdk.x86_64-linux (sdkPkgs: with sdkPkgs; [
     cmdline-tools-latest
     platform-tools
     add-ons-addon-google-apis-google-24
     build-tools-36-0-0
     platforms-android-36
     sources-android-36
     emulator
     system-images-android-36-google-apis-x86-64
     system-images-android-36-google-apis-playstore-x86-64
  ]);
  androidSdkPath = "${androidSdk}/share/android-sdk";

in
{
  environment.systemPackages = with pkgs; [
    androidSdk
    gradle
    jdk17
    firebase-tools
    qemu_kvm
    xorg.libX11
    ruby
    bundler
    (android-studio.override { forceWayland = true;}) # to fix studio with hiDPI monitors
  ];
  
  programs.adb.enable = true;
  users.users.${username}.extraGroups = [ "adbusers" "kvm" ];
  
  environment.variables = {
    ANDROID_HOME = androidSdkPath; # Primary as per docs
    ANDROID_SDK_ROOT = androidSdkPath; # Kept for compatibility
    GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=$ANDROID_HOME/libexec/android-sdk/build-tools/36.0.0/aapt2";
    JAVA_HOME = pkgs.jdk17.home;
    _JAVA_AWT_WM_NONREPARENTING = "1";

    # assuming that you have programs.adb.enable = true; and  ["kvm" "adbusers"] groups added
    # emulator related: vulkan-loader and libGL shared libs are necessary for hardware decoding
    LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [
      pkgs.vulkan-loader
      pkgs.libGL
    ]}";
  };
  
  environment.shellInit = ''
    export PATH="$PATH:$HOME/.pub-cache/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"
  '';
}
