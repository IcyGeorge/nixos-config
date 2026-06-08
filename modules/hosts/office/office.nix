{ inputs, self, ... }: {
  # lightweight travel laptop
  flake.nixosConfigurations.office = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      office
    ];
  };


  flake.nixosModules.office = { pkgs, ... }: {
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
      alacritty
      zsh

      helix
      yazi

      zellij

      androidStudio

      firefox

      workFlatpaks
    ];

  };
}
