# Raycast configuration
{ config, lib, pkgs, vars, ... }:

{
  # Install Raycast through Homebrew
  homebrew.casks = [
    "raycast"
  ];

  # Configure Raycast through home-manager
  home-manager.users.${vars.user} = {
    # Store Raycast settings in ~/.config/raycast/config.json
    home.file.".config/raycast/config.json".text = builtins.toJSON {
      enableCommandHandoff = true;
      enableBrowserExtension = true;
      enableSmartCommands = true;
      showGlobalQueryShortcut = true;
      theme = "raycast-dark";
      searchShortcut = {
        hotkey = "cmd+space";
        enabled = true;
      };
      quickLinkHotkey = {
        hotkey = "cmd+shift+space";
        enabled = true;
      };
      windowBehavior = {
        hideOnBlur = true;
        ignoreBlurClass = [];
      };
      extensions = {
        enabledExtensions = [
          "calculator"
          "calendar"
          "clipboard-history"
          "color-picker"
          "currency-converter"
          "github"
          "google-chrome"
          "ip-geolocation"
          "kill-process"
          "music"
          "quicklinks"
          "raycast-ai"
          "reminders"
          "system"
          "terminal-finder"
          "timer"
          "todo"
          "weather"
        ];
      };
      quicklinks = [
        {
          name = "GitHub";
          url = "https://github.com";
          hotkey = "cmd+shift+g";
        }
        {
          name = "Gmail";
          url = "https://mail.google.com";
          hotkey = "cmd+shift+m";
        }
      ];
    };

    # Store Raycast scripts in ~/.local/share/raycast/scripts
    home.file.".local/share/raycast/scripts" = {
      recursive = true;
      source = ../files/raycast/scripts;
      executable = true;
    };
  };
} 