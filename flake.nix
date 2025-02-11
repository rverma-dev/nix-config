#
#  flake.nix *
#   ├─ ./hosts
#   │   └─ default.nix
#   ├─ ./hosts/darwin
#       └─ default.nix


{
  description = "Nix Darwin System Flake Configuration for M1 MacOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Nix Packages (Default)
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11"; # Stable Nix Packages

    # User Environment Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # MacOS Package Management
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Homebrew Management
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };

    # Homebrew Taps
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    # NUR Community Packages
    nur = {
      url = "github:nix-community/NUR";
    };

    # Neovim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-stable, home-manager, darwin, nur, nixvim, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, ... }:
    let
      # Variables Used In Flake
      vars = {
        user = "rohitverma";
        location = "$HOME/.setup";
        terminal = "kitty";
        editor = "nvim";
      };
    in
    {
      darwinConfigurations = (
        import ./hosts/darwin {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-stable home-manager darwin nur nixvim vars nix-homebrew homebrew-core homebrew-cask homebrew-bundle;
        }
      );
    };
}
