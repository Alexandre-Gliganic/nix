{ pkgs, ... }:
{
  programs.git = {
    includes = [{
      path = "/home/alex/.gitconfig-forge";
      condition = "gitdir:/home/alex/forge/";
    }];
  };
}
