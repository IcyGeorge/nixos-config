{userSettings, ...}:
{
  
  home-manager.users.${userSettings.username} = {
    programs.ssh = {
      enable = true;
      matchBlocks = {
        github = {
          host = "github.com";
          hostname = "ssh.github.com";
          port = 443;
          user = "git";
          identityFile = "~/.ssh/id_ed25519";
          identitiesOnly = true;
        };
      };
    };
    services.ssh-agent.enable = true;
  };
}

