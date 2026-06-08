{
  flake.nixosModules.core = { pkgs, lib, ... }: {
    security.sudo.extraRules = [{
      users = [ "gmelika" ];
      commands = [{
        command = "/run/current-system/sw/bin/nixos-rebuild";
        options = [ "NOPASSWD" ];
      }];
    }];

    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings = {
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCUSeBc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    zramSwap = {
      enable = true;
      priority = 100;
      memoryPercent = 50;
      algorithm = "zstd";
    };

    services = {
      xserver = {
        enable = true;
        xkb.layout = "us";
        excludePackages = [ pkgs.xterm ];
        displayManager.lightdm.enable = lib.mkForce false;
      };
      libinput = {
        enable = true;
      };
    };
    # To prevent getting stuck at shutdown
    systemd.services.NetworkManager.serviceConfig.TimeoutStopSec = "15s";

    networking.networkmanager.enable = true;
    time.timeZone = "Africa/Cairo";
    i18n.defaultLocale = "en_US.UTF-8";
    console.keyMap = "us";

    users.users.gmelika = {
      isNormalUser = true;
      description = "George Melika";
      extraGroups = [ "wheel" "networkmanager" "kvm" ];
    };
    hjem.users.gmelika = {
      user = "gmelika";
      directory = "/home/gmelika";
    };

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    environment.systemPackages = with pkgs; [
      nixpkgs-fmt
      nixd
      helix
      vim
      git
      curl
      wget
    ];

    services.printing.drivers = with pkgs; [ epsonscan2 ];
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # Don't touch this
    system.stateVersion = "25.05";
  };
}
