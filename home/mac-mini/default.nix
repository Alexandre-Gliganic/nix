{ config, pkgs, ... }:
{
  imports =
    [
      ./packages.nix
      ./fish.nix
      ./git.nix
      ../../modules/direnv.nix
      ../../modules/fish.nix
      ../../modules/git.nix
      ../../modules/neovim.nix
      ../../modules/starship.nix
      ../../modules/zoxide.nix
    ];

  home.stateVersion = "22.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;

  programs = {
    direnv.enable = true;
    fish.enable = true;
    git.enable = true;
    neovim.enable = true;
    starship.enable = true;
    zoxide.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "bat";
  };

}
