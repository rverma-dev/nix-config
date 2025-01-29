# Git configuration
{ config, lib, pkgs, vars, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gh # GitHub CLI
  ];

  home-manager.users.${vars.user} = {
    home.stateVersion = "23.11";

    programs.git = {
      enable = true;
      userName = "Rohit Verma";
      userEmail = "rohit.verma@jupiter.money";

      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };
  };
} 