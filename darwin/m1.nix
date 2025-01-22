#
#  Specific system configuration settings for MacBook Air M1 10,1
#
#  flake.nix
#   └─ ./darwin
#       ├─ default.nix
#       └─ ./m1.nix *
#

{ pkgs, vars, ... }:

{
  imports = import (./modules);

  # Enable TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  aerospace.enable = true;

  environment = {
    systemPackages = with pkgs; [
      zsh-powerlevel10k # Prompt
    ];
  };

  homebrew = {
    casks = [
      "cursor"
      "chatgpt"
    ];
    masApps = {
      "Keynote" = 409183694;
      "Numbers" = 409203825;
      "Pages" = 409201541;
    };
  };

  system = {
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.trackpad.enableSecondaryClick" = true;
        # "com.apple.keyboard.fnState" = true;
      };
      dock = {
        autohide = false;
        autohide-delay = 0.2;
        autohide-time-modifier = 0.1;
        magnification = false;
        mineffect = "scale";
        # minimize-to-application = true;
        orientation = "bottom";
        showhidden = false;
        show-recents = false;
        tilesize = 40;
        persistent-apps = [
          "/System/Applications/Launchpad.app"
          "/Applications/Safari.app"
          "/System/Applications/Calendar.app"
          "/Applications/Google Chrome.app"
          "/Applications/Nix Apps/Obsidian.app"
          "/Applications/Nix Apps/kitty.app"
          "/Applications/Cursor.app"
          "/Applications/ChatGPT.app"
          "/System/Applications/System Settings.app"
          "/System/Applications/iPhone Mirroring.app"
        ];
        persistent-others = ["/Users/${vars.user}/Downloads"];
      };
      finder = {
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
      };
      magicmouse = {
        MouseButtonMode = "TwoButton";
      };

      CustomUserPreferences = {
        # Settings of plist in ~/Library/Preferences/
        "com.apple.finder" = {
          # Set home directory as startup window
          NewWindowTargetPath = "file:///Users/${vars.user}/";
          NewWindowTarget = "PfHm";
          # Set search scope to directory
          FXDefaultSearchScope = "SCcf";
          # Multi-file tab view
          FinderSpawnTab = true;
        };
        "com.apple.desktopservices" = {
          # Disable creating .DS_Store files in network an USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        # Show battery percentage
        "~/Library/Preferences/ByHost/com.apple.controlcenter".BatteryShowPercentage = true;
        # Privacy
        "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
      };
      CustomSystemPreferences = {
        # ~/Library/Preferences/
      };
    };
  };
}
