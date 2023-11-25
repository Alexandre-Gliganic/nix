{ config, pkgs, ... }:
{
  imports = [
    ./configuration.nix
    ./hardware.nix
  ];
}
