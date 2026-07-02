{ inputs, self, lib, ... }: {
  # office workstation
  flake.nixosConfigurations.office = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      office
    ];
  };


  flake.nixosModules.office = { pkgs, lib, ... }: {
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
      inkscape

      androidStudio

      firefox

      workFlatpaks

      jovianSteam

      kodi
    ];

    jovian.steam.autoStart = lib.mkForce false;
    jovian.steamos.useSteamOSConfig = lib.mkForce false;
  };
}
