# DevOps/SRE tools and configurations
{ config, lib, pkgs, vars, ... }:

{
  environment.systemPackages = with pkgs; [
    jq
    wget
    # AWS Tools
    awscli2
    granted
    ssm-session-manager-plugin

    # Kubernetes Tools
    kubectl
    kubectx
    k9s
    krew
    kubernetes-helm
    stern
    kustomize

    # Infrastructure Tools
    terraform
    terraform-ls
    terragrunt
    tflint
    testkube
    
    # Development Tools
    jq
    yq
    fzf
    ripgrep
    bat      # Better cat
    btop     # Better top
    atuin    # Shell history

    # Cloud Native Tools
    # istioctl
    # argocd
  ];


  # Create scripts directory
  home-manager.users.${vars.user} = {
    home.file.".local/bin" = {
      recursive = true;
      source = ../files/scripts;
      executable = true;
    };
    home.sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.krew/bin"
    ];
  };
} 
