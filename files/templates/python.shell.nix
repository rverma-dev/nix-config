# Python project shell
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python311
    python311Packages.pip
    python311Packages.virtualenv
    python311Packages.python-lsp-server
    nodePackages.pyright  # Python type checker
  ];

  shellHook = ''
    echo "Python development environment loaded"
    echo "Python: $(python --version)"
  '';
} 