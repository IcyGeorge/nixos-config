{ inputs, self, ... }: {
  # lightweight travel laptop
  flake.nixosConfigurations.x13 = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      x13
    ];
  };


  flake.nixosModules.x13 = { pkgs, ... }: {
    imports = with self.nixosModules; [
      core
      hjem

      audio
      graphics

      niri
      noctalia

      alacritty

      keyd

      fonts

      greetd

      helix
      firefox
      zsh

      yazi
      lazygit
      zellij
    ];

  };
}
