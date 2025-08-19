{ pkgs, ... }: {
  hardware.graphics = {
    package = pkgs.mesa;
    package32 = pkgs.pkgsi686Linux.mesa;
    extraPackages = [ pkgs.mesa ];
    extraPackages32 = [ pkgs.pkgsi686Linux.mesa ];
  };
}
