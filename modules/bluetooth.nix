{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ blueman ];
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        MultiProfile = "multiple";
        FastConnectable = true;
      };
      LE = {
        ScanIntervalSuspend = 2240;
        ScanWindowSuspend = 224;
      };
    };
  };
  services.blueman.enable = true;
}
