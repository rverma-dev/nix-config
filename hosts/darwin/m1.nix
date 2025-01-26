#
#  Specific system configuration settings for MacBook Pro M1
#
#  flake.nix
#   └─ ./hosts
#       └─ ./darwin
#           ├─ common.nix
#           └─ m1.nix *
#

{ pkgs, vars, ... }:

{
  # M1-specific settings
  security.pam.enableSudoTouchIdAuth = true;
  aerospace.enable = true;

  # M1-specific development tools
  environment = {
    systemPackages = with pkgs; [
      temurin-bin-17        
      kotlin           
      kotlin-language-server 
      ktlint          
      visualvm
      obsidian
    ];
    variables = {
      JAVA_HOME = "${pkgs.temurin-bin-17}";
      JAVA_HOME_17 = "${pkgs.temurin-bin-17}";
    };
  };

  # M1-specific applications
  homebrew = {
    casks = [
      "cursor"
      "chatgpt"
      "logi-options+"
    ];
    masApps = {
      "Keynote" = 409183694;
      "Numbers" = 409203825;
      "Pages" = 409201541;
    };
  };

  # M1-specific dock configuration
  system.defaults.dock.persistent-apps = [
    "/System/Applications/Launchpad.app"
    "/Applications/Safari.app"
    "/System/Applications/Calendar.app"
    "/Applications/Google Chrome.app"
    "${pkgs.obsidian}/Applications/Obsidian.app"
    "/Applications/Cursor.app"
    "/System/Applications/System Settings.app"
    "/System/Applications/iPhone Mirroring.app"
    "/Applications/Slack.app"
  ];
  system.defaults.dock.persistent-others = ["/Users/${vars.user}/Downloads"];
}