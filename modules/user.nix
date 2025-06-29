{userSettings, ...}:
{
  users.users.gmelika = {
    isNormalUser = true;
    description = userSettings.fullName;
    extraGroups = [ "networkmanager" "wheel" ];
  };

}
