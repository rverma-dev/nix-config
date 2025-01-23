#
# Project-specific Node.js development environment
# 
# Usage:
# Default (Node.js 20):
#   $ nix-shell
# 
# Specific version:
#   $ nix-shell --arg nodeVersion "nodejs_18"
#   $ nix-shell --arg nodeVersion "nodejs_16"
#   $ nix-shell --arg nodeVersion "nodejs"  # Latest
#

{ nodeVersion ? "nodejs_20" }:

with import <nixpkgs> { };
mkShell {
  name = "NPM-Project-Shell";
  buildInputs = with pkgs; [
    # Use the specified Node.js version
    (pkgs.${nodeVersion})
    nodePackages.npm
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.yarn
    nodePackages.pnpm
  ];

  shellHook = ''
    mkdir -p .npm-project
    npm set prefix .npm-project
    export PATH="$PWD/.npm-project/bin:$PATH"
    echo "Project Node.js environment loaded:"
    echo "Node: $(node --version)"
    echo "NPM: $(npm --version)"
    echo "TypeScript: $(tsc --version)"
    echo "Project-specific packages will be installed in ./.npm-project"
    echo "Global packages are available from ~/.npm-global"
  '';
}
