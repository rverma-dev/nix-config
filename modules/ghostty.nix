# Ghostty Terminal Configuration
{ config, lib, pkgs, vars, ... }:

{
  homebrew.casks = [
    "ghostty"
  ];

  # Configure Ghostty through home-manager
  home-manager.users.${vars.user} = {
    home.file.".config/ghostty/config".text = ''
      # General settings
      font-family = "JetBrainsMono Nerd Font"
      font-size = 14
      window-padding-x = 10
      window-padding-y = 10
      window-theme = "dark"
      macos-option-as-alt = true
      
      # Colors - Catppuccin Macchiato theme
      background = #24273a
      foreground = #cad3f5
      
      # Black
      palette = 0=#494d64
      palette = 8=#5b6078
      
      # Red
      palette = 1=#ed8796
      palette = 9=#ed8796
      
      # Green
      palette = 2=#a6da95
      palette = 10=#a6da95
      
      # Yellow
      palette = 3=#eed49f
      palette = 11=#eed49f
      
      # Blue
      palette = 4=#8aadf4
      palette = 12=#8aadf4
      
      # Magenta
      palette = 5=#f5bde6
      palette = 13=#f5bde6
      
      # Cyan
      palette = 6=#8bd5ca
      palette = 14=#8bd5ca
      
      # White
      palette = 7=#b8c0e0
      palette = 15=#a5adcb
      
      # Cursor
      cursor-color = #f4dbd6
      cursor-style = block
      cursor-blink = true
      
      # Selection
      selection-background = #5b6078
      selection-foreground = #cad3f5
      
      # Shell integration
      shell-integration = zsh
      shell-integration-features = no-cursor,sudo
      
      # Performance
      vsync = true
      
      # Window
      window-save-state = true
      window-inherit-working-directory = true
      
      # Keybindings
      keybind = super+n=new_window
      keybind = super+shift+n=new_window_with_cwd
      keybind = super+t=new_tab
      keybind = super+shift+t=new_tab_with_cwd
      keybind = super+w=close_surface
      keybind = super+shift+w=close_window
      keybind = super+shift+q=quit
      keybind = super+shift+r=reload_config
      
      # Tab navigation
      keybind = super+1=goto_tab:0
      keybind = super+2=goto_tab:1
      keybind = super+3=goto_tab:2
      keybind = super+4=goto_tab:3
      keybind = super+5=goto_tab:4
      keybind = super+6=goto_tab:5
      keybind = super+7=goto_tab:6
      keybind = super+8=goto_tab:7
      keybind = super+9=goto_tab:8
      
      # Split panes
      keybind = super+d=new_split:right
      keybind = super+shift+d=new_split:down
      
      # Pane navigation
      keybind = super+h=move_focus:left
      keybind = super+j=move_focus:down
      keybind = super+k=move_focus:up
      keybind = super+l=move_focus:right
    '';
  };
} 