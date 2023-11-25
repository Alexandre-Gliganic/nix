{ config, pkgs, ... }:
{
  imports =
    [
      ./direnv.nix
      ./fish.nix
      ./git.nix
      ./gpg.nix
      ./neovim.nix
      ./packages.nix
      ./starship.nix
      ./zoxide.nix
    ];

  home.homeDirectory = "/home/alex";
  home.stateVersion = "22.11"; # Please read the comment before changing.

  programs.home-manager.enable = true;

  home.sessionVariables = { EDITOR = "nvim"; PAGER = "bat"; };

}
