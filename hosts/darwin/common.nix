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

  # User configuration
  users.users.${vars.user} = {
    home = "/Users/${vars.user}";
  };

  # Common system packages
  environment.systemPackages = with pkgs; [
    mas # Mac App Store CLI
  ];

  # Homebrew configuration
  homebrew = {
    enable = true;
    onActivation = {
      upgrade = false;
      cleanup = "zap";
    };
    casks = [];
    masApps = {};
  };

  # Nix configuration
  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.stateVersion = 5;
}
