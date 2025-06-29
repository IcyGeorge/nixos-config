{userSettings, pkgs, ...}: {
  home-manager.users.${userSettings.username}.home.packages = with pkgs; [
    gedit #TODO: add emacs with config
  ];
}
