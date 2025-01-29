#
#  Shell Configuration
#

{ pkgs, vars, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      eza # Ls
      zsh-powerlevel10k # Prompt
    ];
    shells = [ pkgs.zsh ]; # Add zsh to available shells
  };

  # Enable zsh system-wide
  programs.zsh.enable = true;

  home-manager.users.${vars.user} = {
    home.file.".p10k.zsh".source = ./p10k.zsh;

    programs = {
      zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        enableCompletion = true;
        history.size = 10000;

        # Environment variables
        envExtra = ''
          # Path configuration
          export PATH="$HOME/.local/bin:$PATH"

          # Granted configuration
          export GRANTED_AWS_CONFIG_FILE="$HOME/.aws/config"
          export AWS_REGION="ap-south-1"

          # Kubernetes configuration
          export KUBECONFIG="$HOME/.kube/config"

          # Editor configuration
          export EDITOR="${vars.editor}"
          export VISUAL="${vars.editor}"
        '';

        # Shell initialization
        initExtra = ''
          # Load powerlevel10k theme
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

          # Configure autosuggestions
          ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#757575'

          # Load completions
          autoload -Uz compinit
          compinit

          # Better directory navigation
          setopt AUTO_CD              # If command is a path, cd into it
          setopt AUTO_PUSHD           # Push the old directory onto the stack on cd
          setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack
          setopt PUSHD_SILENT         # Do not print directory stack

          # History settings
          setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format
          setopt SHARE_HISTORY             # Share history between all sessions
          setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history
          setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again
          setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate
          setopt HIST_FIND_NO_DUPS         # Do not display a line previously found
          setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space
          setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file
          setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry
        '';

        # Shell aliases
        shellAliases = {
          # System aliases
          ls = "${pkgs.eza}/bin/eza --icons=always --color=always";
          l = "ls -l";
          ll = "ls -l";
          la = "ls -la";
          lt = "ls --tree";
          cat = "bat";
          tree = "eza --tree";

          # Directory navigation
          ".." = "cd ..";
          "..." = "cd ../..";
          "...." = "cd ../../..";
          "....." = "cd ../../../..";
          
          # Git aliases
          g = "git";
          ga = "git add";
          gc = "git commit";
          gco = "git checkout";
          gcp = "git cherry-pick";
          gdiff = "git diff";
          gl = "git pull";
          gp = "git push";
          gst = "git status";
          gsw = "git switch";

          # AWS/Granted aliases
          assume = "source assume";

          # Docker aliases
          d = "docker";
          dc = "docker-compose";

          # Kubernetes aliases
          k = "kubectl";
          kg = "kubectl get";
          kns = "kubecns";
          kcx = "kubectx";
          
          # Development aliases
          kt = "kotlin";
          ktc = "kotlinc";
          gw = "./gradlew";
        };
      };
    };
  };
}
