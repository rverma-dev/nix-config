# Node.js development environment
{ config, lib, pkgs, vars, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs_20
    nodePackages.npm
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.yarn
    nodePackages.pnpm
  ];

  environment.variables = {
    NPM_CONFIG_PREFIX = "$HOME/.npm-global";
  };

  environment.extraInit = ''
    export PATH="$HOME/.npm-global/bin:$PATH"
  '';
} 