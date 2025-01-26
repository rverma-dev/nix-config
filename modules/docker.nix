# Docker development environment
{ config, lib, pkgs, vars, ... }:

{
  environment.systemPackages = with pkgs; [
    colima
    docker
    docker-compose
    docker-credential-helpers
  ];

  # Add docker group and user (NixOS only)
  users.users = lib.mkIf (pkgs.stdenv.isLinux) {
    ${vars.user}.extraGroups = [ "docker" ];
  };
} 