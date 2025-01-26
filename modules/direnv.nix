# Direnv configuration with nix-direnv integration
{ config, lib, pkgs, vars, ... }:

{
  # Enable direnv and nix-direnv
  home-manager.users.${vars.user} = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      stdlib = ''
        # Lay out Python virtual environment
        layout_python() {
          local python="''${1:-python3}"
          unset PYTHONHOME
          if [[ -n $VIRTUAL_ENV ]]; then
            VIRTUAL_ENV="$(expand_path ".venv")"
          else
            local python_version
            python_version="$("$python" -c "import platform; print(platform.python_version())")"
            if [[ -z $python_version ]]; then
              log_error "Could not detect Python version"
              return 1
            fi
            VIRTUAL_ENV="$(expand_path ".direnv/python-$python_version")"
          fi
          export VIRTUAL_ENV
          if [[ ! -d $VIRTUAL_ENV ]]; then
            log_status "Creating virtual environment..."
            "$python" -m venv "$VIRTUAL_ENV"
          fi
          PATH_add "$VIRTUAL_ENV/bin"
        }

        # Lay out Node.js environment
        layout_node() {
          NODE_VERSION="''${1:-22}"
          export NODE_VERSION
          export NODE_PATH="$PWD/.direnv/node_modules"
          export NPM_CONFIG_PREFIX="$PWD/.direnv/npm-global"
          PATH_add ".direnv/npm-global/bin"
          log_status "Node.js version set to: $NODE_VERSION"
        }
      '';
    };
  };
} 