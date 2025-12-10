{ pkgs, ... }: {
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
}
