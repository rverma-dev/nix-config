#
#  Shell
#

{ pkgs, vars, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      eza # Ls
      zsh-powerlevel10k # Prompt
      just
    ];
  };

  home-manager.users.${vars.user} = {
    home.file.".p10k.zsh".source = ./p10k.zsh;

    programs = {
      zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        enableCompletion = true;
        history.size = 10000;

        envExtra = ''
          # Granted environment variables
          export GRANTED_ENABLE_AUTO_REASSUME=true
          export GRANTED_AWS_CONFIG_FILE="$HOME/.aws/config"
          export AWS_REGION="ap-south-1"

          # Kubernetes environment variables
          export KUBECONFIG="$HOME/.kube/config"
        '';
        initExtra = ''
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

          ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#757575'

          alias ls="${pkgs.eza}/bin/eza --icons=always --color=always"
          alias finder="ofd" # open find in current path.
          #cdf will change directory to active finder directory

          # Load completions
          autoload -U compinit && compinit
          
          # Load granted completion
          if command -v granted &> /dev/null; then
            source <(granted completion -s zsh)
          fi
        '';
      };
    };
  };
}
