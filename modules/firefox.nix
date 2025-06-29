{userSettings, pkgs, ...}: {
  home-manager.users.${userSettings.username}.programs.firefox = {
    enable = true;
  };
}
