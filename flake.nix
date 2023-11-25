{
  description = "Nix system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
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
      };
    };
}
