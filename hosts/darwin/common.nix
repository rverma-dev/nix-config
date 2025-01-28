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
        # "com.apple.Safari" = {
        #   # Privacy: don’t send search queries to Apple
        #   UniversalSearchEnabled = false;
        #   SuppressSearchSuggestions = true;
        #   # Press Tab to highlight each item on a web page
        #   WebKitTabToLinksPreferenceKey = true;
        #   ShowFullURLInSmartSearchField = true;
        #   # Prevent Safari from opening ‘safe’ files automatically after downloading
        #   AutoOpenSafeDownloads = false;
        #   ShowFavoritesBar = false;
        #   IncludeInternalDebugMenu = true;
        #   IncludeDevelopMenu = true;
        #   WebKitDeveloperExtrasEnabledPreferenceKey = true;
        #   WebContinuousSpellCheckingEnabled = true;
        #   WebAutomaticSpellingCorrectionEnabled = false;
        #   AutoFillFromAddressBook = false;
        #   AutoFillCreditCardData = false;
        #   AutoFillMiscellaneousForms = false;
        #   WarnAboutFraudulentWebsites = true;
        #   WebKitJavaEnabled = false;
        #   WebKitJavaScriptCanOpenWindowsAutomatically = false;
        #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks" = true;
        #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
        #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled" = false;
        #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled" = false;
        #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles" = false;
        #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically" = false;
        # };
      };
    };
  };

  # Common home-manager configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${vars.user} = {
      home.stateVersion = "23.11";

      programs = {
        git = {
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
    };
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
      git # Version Control
      mas # Mac App Store $ mas search <app>
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
