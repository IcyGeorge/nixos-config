{
  flake.nixosModules.lazygit = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.lazygit ];
  };
}
