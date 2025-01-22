# Aliases for shell commands
{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    initExtra = ''
      # Docker Aliases
      alias d="docker"
      alias dc="docker-compose"

      # Kubernetes Aliases
      alias k="kubectl"
      alias kgp="kubectl get pods"
      alias kgs="kubectl get services"
      alias kcu="kubectl config use-context"
      alias kcu="kubectl config use-context"
      alias kcg="kubectl config get-contexts"
      alias kcd="kubectl config delete-context"
    '';
  };
} 