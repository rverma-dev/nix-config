#
#  Tiling Window Manager for MacOS
#  Enable with "aerospace.enable = true;"
#
#  Fix tiny mission control windows: System settings -> Desktop & Dock -> Mission Control -> Enable "Group Windows By Application"
#  Navigate workspaces using gestures: Install BetterTouchTool -> Create 2 and 3-finger gestures for trackpad and magic mouse ->
#    Use "Execute Terminal Command": "/etc/profiles/per-user/${username}/bin/aerospace workspace "$(/etc/profiles/per-user/${username}/bin/aerospace list-workspaces --monitor mouse --visible)" && /etc/profiles/per-user/${username}/bin/aerospace workspace next" (use next or prev)
#

{ config, lib, pkgs, vars, ... }:

with lib;
{
  options.aerospace = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = mdDoc ''
        Tiling Window Manager for MacOS
      '';
    };
  };

  config = mkIf config.aerospace.enable {
    home-manager.users.${vars.user} = {
      home.packages = with pkgs; [ aerospace jankyborders ];
      xdg.configFile."aerospace/aerospace.toml".text = ''
        start-at-login = true

        # Normalization settings
        enable-normalization-flatten-containers = true
        enable-normalization-opposite-orientation-for-nested-containers = true

        # Accordion layout settings
        accordion-padding = 0

        # Default root container settings
        default-root-container-layout = 'tiles'
        default-root-container-orientation = 'auto'

        # Mouse follows focus settings
        on-focused-monitor-changed = ['move-mouse monitor-lazy-center']
        on-focus-changed = ['move-mouse window-lazy-center']

        # Automatically unhide macOS hidden apps
        automatically-unhide-macos-hidden-apps = true

        after-startup-command = [
          'exec-and-forget ${pkgs.jankyborders}/bin/borders active_color=0xffa6a6a6 inactive_color=0x00a6a6a6 style=round width=5.0'
        ]

        # Window Rules for Picture-in-Picture
        [[on-window-detected]]
        if.app-id = "com.google.Chrome"
        if.window-title-regex-substring = "Picture[ -]in[ -][Pp]icture"
        run = "layout floating"
        check-further-callbacks = true

        [gaps]
        inner.horizontal = 0
        inner.vertical = 0
        outer.left = 0
        outer.bottom = 0
        outer.top = 0
        outer.right = 0

        [mode.main.binding]
        # Launch applications
        alt-shift-enter = 'exec-and-forget open -na ${vars.terminal}'

        # Window management
        alt-q = "close"
        alt-slash = 'layout tiles horizontal vertical'
        alt-comma = 'layout accordion horizontal vertical'
        alt-m = 'fullscreen'

        # Focus movement
        alt-j = 'focus left'
        alt-k = 'focus down'
        alt-i = 'focus up'
        alt-l = 'focus right'

        # Window movement
        alt-shift-j = 'move left'
        alt-shift-k = 'move down'
        alt-shift-i = 'move up'
        alt-shift-l = 'move right'

        # Resize windows
        alt-shift-minus = 'resize smart -50'
        alt-shift-equal = 'resize smart +50'

        # Workspace management
        alt-1 = 'workspace 1'
        alt-2 = 'workspace 2'
        alt-3 = 'workspace 3'
        alt-4 = 'workspace 4'
        alt-5 = 'workspace 5'
        alt-6 = 'workspace 6'
        alt-7 = 'workspace 7'
        alt-8 = 'workspace 8'
        alt-9 = 'workspace 9'

        # Move windows to workspaces
        alt-shift-1 = 'move-node-to-workspace 1'
        alt-shift-2 = 'move-node-to-workspace 2'
        alt-shift-3 = 'move-node-to-workspace 3'
        alt-shift-4 = 'move-node-to-workspace 4'
        alt-shift-5 = 'move-node-to-workspace 5'
        alt-shift-6 = 'move-node-to-workspace 6'
        alt-shift-7 = 'move-node-to-workspace 7'
        alt-shift-8 = 'move-node-to-workspace 8'
        alt-shift-9 = 'move-node-to-workspace 9'

        # Workspace navigation
        alt-tab = 'workspace-back-and-forth'
        alt-shift-tab = 'move-workspace-to-monitor --wrap-around next'

        # Enter service mode
        alt-shift-semicolon = 'mode service'

        [mode.service.binding]
        # Reload config and exit service mode
        esc = ['reload-config', 'mode main']
        r = ['flatten-workspace-tree', 'mode main']
        f = ['layout floating tiling', 'mode main']
        backspace = ['close-all-windows-but-current', 'mode main']
      '';
    };
  };
}
