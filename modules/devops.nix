# DevOps/SRE tools and configurations
{ config, lib, pkgs, vars, ... }:

{
  environment.systemPackages = with pkgs; [
    # AWS Tools
    saml2aws
    awscli2
    aws-vault
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

  environment.variables = {
    AWS_REGION = "ap-south-1";  # Default AWS region
    SAML2AWS_SESSION_DURATION = "3600";
    KUBECONFIG = "$HOME/.kube/config";
  };

  # Create scripts directory
  home-manager.users.${vars.user} = {
    home.file.".local/bin" = {
      recursive = true;
      source = ../files/scripts;
      executable = true;
    };
  };
} 