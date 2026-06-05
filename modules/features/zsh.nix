{
  flake.nixosModules.zsh = { pkgs, ... }: {

    users.defaultUserShell = pkgs.zsh;
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
    programs.starship.enable = true;

    hjem.users.gmelika = {
      files = {
        ".config/starship.toml".source = ../../dots/starship.toml;
      };
    };
  };
}
