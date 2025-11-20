{ pkgs, ... }:
{
  hardware.graphics = {
    enable32Bit = true;
    extraPackages = with pkgs; [ rocmPackages.clr ];
  };
}
