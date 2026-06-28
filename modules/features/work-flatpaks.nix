{ inputs, ... }: {
  flake.nixosModules.workFlatpaks = { ... }: {
    imports = [
      inputs.nix-flatpak.nixosModules.nix-flatpak
    ];

    services.flatpak = {
      enable = true;
      packages = [
        "com.slack.Slack"
      ];
    };

  };
}
