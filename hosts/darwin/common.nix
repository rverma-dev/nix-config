#
#  Common Darwin Configuration
#
#  flake.nix
#   └─ ./hosts
#       └─ ./darwin
#           ├─ common.nix *
#           └─ <host>.nix
#

{ config, pkgs, vars, ... }:

{
  imports = import (../../modules);

  # Common system configuration
  system = {
    defaults = {
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSNavPanelExpandedStateForSaveMode = true;
        PMPrintingExpandedStateForPrint = true;
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.trackpad.enableSecondaryClick" = true;
      };
      LaunchServices = {
        LSQuarantine = false;
      };
      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
      };
      finder = {
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      dock = {
        autohide = true;
        magnification = false;
        mineffect = "scale";
        minimize-to-application = true;
        orientation = "bottom";
        showhidden = false;
        show-recents = false;
        tilesize = 30;
      };
      screencapture = {
        location = "/Users/${vars.user}/Downloads/temp";
        type = "png";
        disable-shadow = true;
      };
      CustomUserPreferences = {
        "com.apple.finder" = {
          NewWindowTargetPath = "file:///Users/${vars.user}/";
          NewWindowTarget = "PfHm";
          FXDefaultSearchScope = "SCcf";
          FinderSpawnTab = true;
        };
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "~/Library/Preferences/ByHost/com.apple.controlcenter".BatteryShowPercentage = true;
        "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
      };
    };
  };

  # Common home-manager configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # Common nix-homebrew configuration
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "${vars.user}";
    autoMigrate = true;
  };

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
      zsh-powerlevel10k # Prompt
      eza # Ls
      git # Version Control
      mas # Mac App Store $ mas search <app>
      wget # Download
      jq
      awscli2
      kubectl
      just
      # ui packages
      obsidian
      raycast
    ];
  };

  programs.zsh.enable = true;

  homebrew = {
    enable = true;
    onActivation = {
      upgrade = false;
      cleanup = "zap";
    };
    casks = [];
    masApps = {};
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
    stateVersion = 5;
  };
}
