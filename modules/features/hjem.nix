{ inputs, ... }: {
  flake.nixosModules.hjem = inputs.hjem.nixosModules.default;
}
