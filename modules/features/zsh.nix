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
        ".zshrc".source = ../../dots/.zshrc;
        ".config/starship.toml".source = ../../dots/starship.toml;
      };
    };
  };
}
