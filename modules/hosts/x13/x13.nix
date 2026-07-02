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
      fonts
      keyd

      greetd
      niri
      noctalia

      git
      kitty
      zsh

      helix
      yazi
      aseprite

      firefox

      kodi
    ];

  };
}
