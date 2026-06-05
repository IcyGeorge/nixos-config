{
  flake.nixosModules.alacritty = { pkgs, lib, ... }: {

    environment.systemPackages = with pkgs; [
      alacritty
    ];

    hjem.users.gmelika = {
      files = {
        ".config/alacritty/alacritty.toml".source = ../../dots/alacritty/alacritty.toml;
      };
    };

  };
}
