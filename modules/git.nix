{ pkgs, ... }:
{
  programs.git = {
    userName = "Alexandre Gliganic";
    userEmail = "alexandre.gliganic@epita.fr";
    signing = {
      key = "F807F783C114DFA4";
      signByDefault = true;
    };
    extraConfig = {
      core = { editor = "nvim"; };
      init = { defaultBranch = "main"; };
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
