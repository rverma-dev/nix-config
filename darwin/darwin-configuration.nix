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
      NPM_CONFIG_PREFIX = "$HOME/.npm-global";  # Set global npm install directory
    };
    extraInit = ''
      export PATH="$HOME/.npm-global/bin:$PATH"
    '';
    systemPackages = with pkgs; [
      eza # Ls
      git # Version Control
      mas # Mac App Store $ mas search <app>
      wget # Download
      jq
      # node setup
      nodejs_20    # LTS version
      nodePackages.npm
      nodePackages.typescript
      nodePackages.typescript-language-server
      yarn-berry
      # docker setup
      colima
      docker
      docker-compose
      docker-credential-helpers
      awscli2
      kubectl
      just
      # ui packages
      obsidian
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
      
    ];
    masApps = {
    };
  };

  home-manager.users.${vars.user} = {
    home.stateVersion = "23.11";

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
