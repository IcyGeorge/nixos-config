{ pkgs, ... }: {

  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.caskaydia-cove
      nerd-fonts.symbols-only
      twemoji-color-font
      noto-fonts-emoji
      fantasque-sans-mono
      maple-mono.truetype-autohint
    ];

    enableDefaultPackages = false;
  };
}
