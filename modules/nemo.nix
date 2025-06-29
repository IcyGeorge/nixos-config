{userSettings, pkgs, ...}: {
  home-manager.users.${userSettings.username}.home.packages = with pkgs; [
    nemo
  ];
}
