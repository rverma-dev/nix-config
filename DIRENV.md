# Project Environment Management with direnv

This repository uses `direnv` and `nix-direnv` to manage project-specific development environments. This allows us to have isolated environments for different projects without installing languages and tools globally.

## Setup

The configuration is already set up in the Nix configuration. After running `darwin-rebuild switch`, direnv will be available.

## Usage

### For a New Project

1. Create your project directory:
```bash
mkdir my-project
cd my-project
```

2. Copy the appropriate template files from `~/.setup/darwin/files/templates/`:
```bash
# For Node.js projects
cp ~/.setup/darwin/files/templates/node.envrc .envrc
cp ~/.setup/darwin/files/templates/node.shell.nix shell.nix

# For Python projects
cp ~/.setup/darwin/files/templates/python.envrc .envrc
cp ~/.setup/darwin/files/templates/python.shell.nix shell.nix
```

3. Allow direnv to load the environment:
```bash
direnv allow
```

### Node.js Version Selection

In your project's `.envrc`, specify the Node.js version:
```bash
# For Node.js 20
layout node 20

# For Node.js 22
layout node 22
```

### Python Version Selection

In your project's `.envrc`, specify the Python version:
```bash
# For default Python 3
layout python python3

# For specific Python version
layout python python3.11
```

## Template Customization

### Node.js Projects

1. `.envrc`: Controls environment activation
2. `shell.nix`: Specifies development dependencies

Example `shell.nix` customization:
```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    nodejs_22        # Change Node.js version
    nodePackages.npm
    # Add more tools as needed
  ];
}
```

### Python Projects

1. `.envrc`: Controls environment activation
2. `shell.nix`: Specifies development dependencies

Example `shell.nix` customization:
```nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python311       # Change Python version
    python311Packages.pip
    # Add more tools as needed
  ];
}
```

## Features

- Automatic environment activation when entering project directories
- Project-specific dependency management
- Isolated environments per project
- Version control friendly
- Reproducible environments across machines

## Common Commands

```bash
direnv allow      # Allow direnv to load the environment
direnv reload     # Reload the environment
direnv status     # Show direnv status
direnv deny       # Revoke environment loading permission
``` 