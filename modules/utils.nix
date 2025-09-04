{ pkgs, config, inputs, ... }:
let
  hostname = config.var.hostname;
  keyboardLayout = config.var.keyboardLayout;
  configDir = config.var.configDirectory;
  timeZone = config.var.timeZone;
  defaultLocale = config.var.defaultLocale;
  autoUpgrade = config.var.autoUpgrade;
in
{
  networking.hostName = hostname;

  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;



  system.autoUpgrade = {
    enable = autoUpgrade;
    dates = "04:00";
    flake = "${configDir}";
    flags = [ "--update-input" "nixpkgs" "--commit-lock-file" ];
    allowReboot = false;
  };

  time = { timeZone = timeZone; };
  i18n.defaultLocale = defaultLocale;


  services = {
    dbus = {
      enable = true;
      implementation = "broker";
    };

    gnome.gnome-keyring.enable = true;

    # Logitech mouse
    ratbagd.enable = true;
    libinput.enable = true;

    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
  };
  console.keyMap = keyboardLayout;

  environment.variables = {
    XDG_DATA_HOME = "$HOME/.local/share";
    PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
    EDITOR = "hx";
    TERMINAL = "kitty";
    TERM = "kitty";
    BROWSER = "firefox";
  };

  programs.dconf.enable = true;

  # Faster rebuilding
  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

  environment.systemPackages = with pkgs; [
    pwvucontrol
    networkmanagerapplet
    wget
    curl
    zip
    unzip
    gparted
  ];

  security = {
    rtkit.enable = true;
    polkit.enable = true;

    # don't ask for password for wheel group
    sudo.wheelNeedsPassword = false;
  };

  # services.logind.extraConfig = ''
  #  # don’t shutdown when power button is short-pressed
  #  HandlePowerKey=ignore
  # '';

}
