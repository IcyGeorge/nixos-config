{ self, inputs, ... }: {

  flake.nixosModules.living =
    { config, lib, pkgs, modulesPath, ... }:

    {
      imports =
        [
          (modulesPath + "/installer/scan/not-detected.nix")
        ];

      boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" =
        {
          device = "/dev/disk/by-uuid/9084aa39-24a0-4e9a-8cf9-332dac8b0621";
          fsType = "ext4";
        };

      fileSystems."/mnt/library" =
        {
          device = "/dev/disk/by-label/Library";
          fsType = "btrfs";
          options = [ "compress=zstd" "noatime" "nofail" ];
        };

      fileSystems."/boot" =
        {
          device = "/dev/disk/by-uuid/1B42-B9C9";
          fsType = "vfat";
          options = [ "fmask=0077" "dmask=0077" ];
        };

      swapDevices = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}

