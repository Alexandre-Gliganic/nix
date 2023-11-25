{ pkgs, ... }:
{
  programs.git = {

    userName = "Alexandre Gliganic";
    userEmail = "alexandre.gliganic@epita.fr";
    signing = {
      key = "F807F783C114DFA4";
      signByDefault = true;
    };

    includes = [{
      path = "/Users/alex/.gitconfig-forge";
      condition = "gitdir:/home/alex/forge/";
    }];
    extraConfig = {
      core = { editor = "nvim"; };
      init = { defaultBranch = "main"; };
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
