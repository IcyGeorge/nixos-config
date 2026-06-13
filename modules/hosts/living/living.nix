{ inputs, self, ... }: {
  # HTPC for steamos and kodi
  flake.nixosConfigurations.living = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      living
    ];
  };


  flake.nixosModules.livig = { pkgs, ... }: {
    imports = with self.nixosModules; [
      core
      hjem

      audio
      graphics
      fonts
      keyd

      jovianSteam
      niri
      noctalia

      git
      kitty
      zsh

      helix
      yazi

      firefox

      kodi
    ];

  };
}
