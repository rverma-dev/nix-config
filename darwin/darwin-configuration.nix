#
#  Main MacOS system configuration.
#
#  flake.nix
#   └─ ./darwin
#       ├─ default.nix
#       ├─ darwin-configuration.nix *
#       └─ ./modules
#           └─ default.nix
#

{ pkgs, vars, ... }:

{
  imports = (import ./modules);

  users.users.${vars.user} = {
    home = "/Users/${vars.user}";
    shell = pkgs.zsh;
  };

  environment = {
    variables = {
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    systemPackages = with pkgs; [
      eza # Ls
      git # Version Control
      mas # Mac App Store $ mas search <app>
      wget # Download
      jq
      nodePackages.typescript
      nodejs
      colima
      docker
      docker-compose
      docker-credential-helpers
      awscli2
      kubectl
      just
    ];
  };

  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    onActivation = {
      upgrade = false;
      cleanup = "zap";
    };
    casks = [
      "cursor"
    ];
    masApps = {    
    };
  };

  home-manager.users.${vars.user} = {
    home.stateVersion = "22.05";
    
    programs.git = {
      enable = true;
      userName = "Rohit Verma";  # Replace with your name
      userEmail = "rohit.verma@jupiter.money";  # Replace with your email
      
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };
  };

  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      # auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
  };

  system = {
    stateVersion = 4;
  };
}
