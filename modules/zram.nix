{ config, ... }: {
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 50;
    algorithm = "zstd";
  };
}

