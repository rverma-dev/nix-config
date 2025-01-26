# Go development environment
{ config, lib, pkgs, vars, ... }:

{
  environment.systemPackages = with pkgs; [
    go
    gopls
    delve
    golangci-lint
  ];

  environment.variables = {
    GOPATH = "$HOME/go";
  };

  environment.extraInit = ''
    export PATH="$GOPATH/bin:$PATH"
  '';
} 