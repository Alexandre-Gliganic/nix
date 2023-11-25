{ pkgs, ... }:
{
  programs.git = {
    includes = [
      {
        path = "/Users/alex/.gitconfig-forge";
        condition = "gitdir:/Users/alex/Documents/EPITA/forge/";
      }
    ];
  };
}
