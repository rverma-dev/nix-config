# Node.js project shell
{ pkgs ? import <nixpkgs> {} }:

let
  # Allow specifying Node.js version through environment variable
  nodeVersion = builtins.getEnv "NODE_VERSION";
  nodePkg = if nodeVersion == "20" then pkgs.nodejs_20
            else pkgs.nodejs_22;  # default to Node.js 22 LTS
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    nodePkg
    nodePackages.npm
    yarn-berry
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];

  shellHook = ''
    echo "Node.js development environment loaded"
    echo "Node: $(node --version)"
    echo "NPM: $(npm --version)"
  '';
} 