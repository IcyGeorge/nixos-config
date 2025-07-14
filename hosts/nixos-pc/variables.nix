{
  config,
  lib,
  ...
}: {
  imports = [
    # Choose your theme here:
    #../../themes/catppuccin.nix
  ];

  config.var = {
    hostname = "nixos-pc";
    username = "gmelika";
    configDirectory =
      "/home/"
      + config.var.username
      + "/nixos-config"; # The path of the nixos configuration directory

    keyboardLayout = "us";

    location = "Cairo";
    timeZone = "Africa/Cairo";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "ar_EG.UTF-8";

    git = {
      username = "icygeorge";
      email = "georgenaiem1@gmail.com";
    };

    autoUpgrade = false;
    autoGarbageCollector = true;
    
    features = {
      androidDev = true; # android
    };
  };

  # Let this here
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
}
