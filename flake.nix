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
  outputs = { self, nixpkgs, home-manager, flake-utils }:
    let
      lib = nixpkgs.lib;

      pkgImport = pkgs: system:
        import pkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
    in
    {
      nixosConfigurations = {
        forge-nuc = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [

            ./hardware/forge-nuc.nix
            ./system/forge-nuc.nix
            ./system/alex.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alex = import ./home/forge-nuc.nix;

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }

          ];
        };
      };
    };
}
