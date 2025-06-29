{ userSettings, lib, pkgs, ... }: {
  home-manager.users.${userSettings.username} = {
    home.packages = with pkgs; [
      lazygit
    ];

    programs.git = {
      enable = true;

      userName = userSettings.fullName;
      userEmail = userSettings.email;


      ignores = [
        "*.log"
        ".DS_Store"
      ];
    };
  };
}
