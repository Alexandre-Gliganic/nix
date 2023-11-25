{ config, pkgs, ... }:
{
  imports =
    [
      ./packages.nix
      ./git.nix
      ../../modules/direnv.nix
      ../../modules/fish.nix
      ../../modules/git.nix
      ../../modules/gpg.nix
      ../../modules/neovim.nix
      ../../modules/starship.nix
      ../../modules/zoxide.nix
    ];

  home.homeDirectory = "/home/alex";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  programs.home-manager.enable = true;

  programs = {
    direnv.enable = true;
    fish.enable = true;
    git.enable = true;
    neovim.enable = true;
    starship.enable = true;
    zoxide.enable = true;
  };

  services = {
    gpg-agent.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "bat";
  };

}
