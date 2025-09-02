# Firefox!.
{ config, ... }:
{
  home-manager.users.${config.var.username} = {
    programs.firefox = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;

        DisablePocket = true;
        DisableProfileImport = true;
        DisableSetDesktopBackground = true;

        StartPage = "homepage";
        NewTabPage = true;

        # find more options here: https://mozilla.github.io/policy-templates/
      };
    };
  };
}
