# Zen is a minimalistic web browser.
{ config, pkgs, inputs, ... }:
{
  home-manager.users.${config.var.username} = {
    imports = [
      inputs.zen-browser.homeModules.beta
    ];

    programs.zen-browser = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;

        AutofillAddressesEnabled = false;
        AutoFillCreditCardEnabled = false;
        DisablePocket = true;
        DisableProfileImport = true;
        DisableSetDesktopBackground = true;
        DontCheckDefaultBrowser = true;
        StartPage = "homepage";
        NewTabPage = true;
        OfferToSaveLogins = false;
        # find more options here: https://mozilla.github.io/policy-templates/
      };
    };
  };
}
