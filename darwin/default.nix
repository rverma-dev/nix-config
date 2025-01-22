#
#  These are the different profiles that can be used when building on MacOS
#
#  flake.nix
#   └─ ./darwin
#       ├─ default.nix *
#       ├─ darwin-configuraiton.nix
#       └─ <host>.nix
#

{ inputs, nixpkgs, nixpkgs-stable, darwin, home-manager, nixvim, vars, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, ... }:

let
  inherit (darwin.lib) darwinSystem;
  inherit (nixpkgs.lib) attrValues makeOverridable optionalAttrs singleton;

  systemConfig = system: {
    system = system;
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  };
in
{  
  # MacBookAir M1
  macbook = 
    let
      inherit (systemConfig "aarch64-darwin") system pkgs stable;
    in
    darwinSystem {
      inherit system;
      specialArgs = { inherit inputs system pkgs stable vars; };
      modules = [
        ./darwin-configuration.nix
        ./m1.nix
        nixvim.nixDarwinModules.nixvim
        home-manager.darwinModules.home-manager
        nix-homebrew.darwinModules.nix-homebrew
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          # Homebrew Configuration
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "${vars.user}";
            autoMigrate = true;
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-bundle" = homebrew-bundle;
            };
          };
        }
      ];
    };
}
