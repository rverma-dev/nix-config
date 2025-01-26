# Enhanced tool configurations
{ config, lib, pkgs, vars, ... }:

{
  home-manager.users.${vars.user} = {
    # Atuin - Better shell history
    programs.atuin = {
      enable = true;
      settings = {
        inline_height = 25;
        invert = true;
        records = true;
        search_mode = "skim";
        secrets_filter = true;
        style = "compact";
      };
      flags = ["--disable-up-arrow"];
    };

    # Lazygit - Git TUI
    programs.lazygit = {
      enable = true;
      settings = {
        git = {
          paging = {
            colorArg = "always";
            pager = "delta --color-only --dark --paging=never";
          };
        };
      };
    };

    # FZF - Fuzzy Finder
    programs.fzf = {
      enable = true;
      defaultCommand = "find .";
      defaultOptions = [
        "--bind '?:toggle-preview'"
        "--bind 'ctrl-a:select-all'"
        "--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'"
        "--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'"
        "--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'"
        "--height=40%"
        "--info=inline"
        "--layout=reverse"
        "--multi"
        "--preview '([[ -f {}  ]] && (bat --color=always --style=numbers,changes {} || cat {})) || ([[ -d {}  ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'"
        "--preview-window=:hidden"
        "--prompt='~ ' --pointer='▶' --marker='✓'"
      ];
    };

    # Bat - Better cat
    programs.bat = {
      enable = true;
      config = {
        theme = "TwoDark";
        italic-text = "always";
      };
    };

    # K9s - Kubernetes TUI
    programs.k9s = {
      enable = true;
      settings = {
        k9s = {
          refreshRate = 2;
          maxConnRetry = 5;
          readOnly = false;
          noIcons = false;
          logger = {
            tail = 100;
            buffer = 5000;
            sinceSeconds = 60;
            fullScreenLogs = false;
            textWrap = false;
            showTime = false;
          };
        };
      };
    };
  };
} 