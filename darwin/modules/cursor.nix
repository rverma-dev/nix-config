#
#  Cursor Configuration
#

{ vars, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.code-cursor
    pkgs.meslo-lgs-nf  # Ensure font is available if not already added in kitty.nix
  ];

  home-manager.users.${vars.user} = {
    home.file = {
      "Library/Application Support/Code/User/settings.json" = {
        text = ''
          {
            // ... existing settings ...
            
            // Cursor settings
            "editor.fontFamily": "MesloLGS Nerd Font Mono",
            "terminal.integrated.fontFamily": "MesloLGS Nerd Font Mono",
            "editor.fontSize": 13,
            "editor.lineHeight": 1.5,
            "editor.cursorStyle": "line",
            "editor.cursorWidth": 2,
            "editor.cursorBlinking": "smooth",
            
            // Optional: Terminal cursor settings
            "terminal.integrated.fontSize": 13,
            "terminal.integrated.cursorStyle": "line",
            "terminal.integrated.cursorBlinking": true
          }
        '';
      };
    };
  };
}
