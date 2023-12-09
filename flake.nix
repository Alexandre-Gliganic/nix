{
  description = "Nix system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, home-manager, flake-utils } @ inputs:
    let
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        config.allowUnfree = true;
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

            ./modules/alex.nix
            ./systems/thinkpad/default.nix

            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = ( import ./overlays );
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alex = import ./home/thinkpad/default.nix ;
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
