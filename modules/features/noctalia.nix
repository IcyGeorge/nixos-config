{ inputs, ... }: {
  flake.nixosModules.noctalia = { pkgs, lib, ... }: {

    environment.systemPackages = with pkgs; [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    services.tuned.enable = true;
    services.upower.enable = true;

    hjem.users.gmelika = {
      files = {
        ".config/noctalia-shell/config.json".source = ../../dots/.config/noctalia/noctalia.json;
      };
    };

  };
}
