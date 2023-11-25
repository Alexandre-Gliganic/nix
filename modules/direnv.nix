{ pkgs, ... }:
{
  programs.direnv = {
    nix-direnv.enable = true;
  };
}
