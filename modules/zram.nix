{ config, ... }: {
  zramSwap.enable = true;
  zramSwap.algorithm = "zstd";
}

