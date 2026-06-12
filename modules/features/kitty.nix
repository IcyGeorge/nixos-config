{
  flake.nixosModules.kitty = { pkgs, lib, ... }: {

    environment.systemPackages = with pkgs; [
      kitty
    ];

    hjem.users.gmelika = {
      files = {
        ".config/kitty/kitty.conf".source = ../../dots/.config/kitty/kitty.conf;

        ".config/kitty/current-theme.conf".source = ../../dots/.config/kitty/current-theme.conf;
      };
    };

  };
}
