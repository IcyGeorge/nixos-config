{
  flake.nixosModules.java = { pkgs, lib, ... }: {
    environment.systemPackages = with pkgs; [
      jdk21
      maven
      gradle
      jdt-language-server
      google-java-format
      (jetbrains.idea.override { forceWayland = true; })
    ];

    environment.variables = {
      JAVA_HOME = lib.mkDefault pkgs.jdk21.home;
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
    ];
  };
}
