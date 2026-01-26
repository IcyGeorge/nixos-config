{ inputs, config, pkgs, ... }:
{

  home-manager.users.${config.var.username} = {
	home.packages = [
		inputs.nixCats.packages.${pkgs.stdenv.hostPlatform.system}.default
	];
  };
}
