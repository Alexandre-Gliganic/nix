{ pkgs, ... }:
{
  programs.zoxide = {
    enableFishIntegration = true;
  };
}
