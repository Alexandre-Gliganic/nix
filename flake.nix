{
  description = "Nix system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, flake-utils, nix-index-database } @ inputs:
    let
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        config.allowUnfree = true;
      };
      overlay-unstable = final: prev: rec {
        unstable = import nixpkgs-unstable {
          inherit (prev) system; # system = prev.system;
          config.allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations = {
        nuc-forge = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [

            ./modules/alex.nix
            ./systems/nuc-forge/default.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alex = import ./home/nuc-forge/default.nix;
            }
          ];
        };

        thinkpad = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })

            ./modules/alex.nix
            ./systems/thinkpad/default.nix
            nix-index-database.nixosModules.nix-index
            home-manager.nixosModules.home-manager
            {
              # nixpkgs.overlays = (import ./overlays);
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alex = import ./home/thinkpad/default.nix;

              nix = {
                nixPath = [
                  "nixpkgs=${nixpkgs}"
                  "nixpkgs-unstable=${nixpkgs-unstable}"
                ];

                registry = {
                  nixpkgs.flake = nixpkgs;
                  nixpkgs-unstable.flake = nixpkgs-unstable;
                };
              };
            }
          ];
        };

      };
      homeConfigurations = {
        mac-mini = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          modules = [

            ./home/mac-mini/default.nix

            {
              home = {
                username = "alex";
                homeDirectory = "/Users/alex";
              };
            }
          ];
        };
        mbp = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          modules = [

            ./home/mbp/default.nix

            {
              home = {
                username = "alex";
                homeDirectory = "/Users/alex";
              };
            }
          ];
        };
      };
    };
}
