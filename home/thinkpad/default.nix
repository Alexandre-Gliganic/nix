{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./packages.nix
      ./git.nix
      ./fish.nix
      ../../modules/direnv.nix
      ../../modules/fish.nix
      ../../modules/git.nix
      ../../modules/gpg.nix
      ../../modules/kitty.nix
      ../../modules/neovim.nix
      ../../modules/starship.nix
      ../../modules/zoxide.nix
    ];


  home.homeDirectory = "/home/alex";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  xsession.windowManager.i3 = import ../../modules/i3.nix { inherit pkgs lib config; };

  programs.home-manager.enable = true;

  programs = {
    direnv.enable = true;
    fish.enable = true;
    git.enable = true;
    kitty.enable = true;
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
    TERMINAL = "kitty";
  };

}
