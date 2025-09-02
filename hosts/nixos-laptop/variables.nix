{ config
, lib
, ...
}: {
  imports = [
    # Choose your theme here:
    #../../themes/catppuccin.nix
  ];

  config.var = {
    hostname = "nixos-laptop";
    username = "gmelika";
    configDirectory =
      "/home/"
      + config.var.username
      + "/nixos-config"; # The path of the nixos configuration directory

    keyboardLayout = "us";

    location = "Cairo";
    timeZone = "Africa/Cairo";
    defaultLocale = "en_US.UTF-8";

    git = {
      username = "icygeorge";
      email = "georgenaiem1@gmail.com";
    };

    autoUpgrade = false;
    autoGarbageCollector = true;

    # Modes
    htpcMode = false;
    androidDevMode = false;
    rustDevMode = true;

  };

  # Let this here
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
  };
}
