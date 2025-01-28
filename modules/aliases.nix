# Aliases for shell commands
{ config, lib, pkgs, vars, ... }:

{
  home-manager.users.${vars.user} = {
    programs.zsh = {
      enable = true;
      shellAliases = {
        assume = "source assume";
        # Docker Aliases
        d = "docker";
        dc = "docker-compose";

        # Kubernetes Aliases
        k = "kubectl";
        kgp = "kubectl get pods";
        kgs = "kubectl get services";
        kcu = "kubectl config use-context";
        kcg = "kubectl config get-contexts";
        kcd = "kubectl config delete-context";

        # Node.js Development Environment Aliases
        nodelatest = "nix-shell ${vars.location}/shells/npm/shell.nix --arg nodeVersion \"nodejs\"";
        
        kt = "kotlin";
        ktc = "kotlinc";
        gw = "./gradlew";
      };
    };
  };
} 