#
#  Terminal Emulator
#

{ vars, pkgs, ... }:

{
  # Install Kitty through home-manager for better integration
  home-manager.users.${vars.user} = {
    programs.kitty = {
      enable = true;
      font = {
        name = "MesloLGS Nerd Font Mono";
        size = 14;
      };
      settings = {
        background_opacity = "0.8";
        hide_window_decorations = "titlebar-only";
        window_padding_width = "4";
        macos_option_as_alt = "yes";
        enabled_layouts = "tall,stack,fat,grid,splits,horizontal,vertical";
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        tab_powerline_style = "round";
      };
    };
  };

  environment.systemPackages = [
    pkgs.meslo-lgs-nf
  ];
}
