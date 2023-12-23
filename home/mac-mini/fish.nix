{ pkgs, ... }:
{
  programs.fish = {
    shellInit = ''
      . ~/.nix-profile/etc/profile.d/nix.fish
      set -x GPG_TTY (tty)
      set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
    '';

    functions = {
      clipboard = { description = "Copy to clipboard"; body = "pbcopy"; wraps = "pbcopy"; };
    };
  };
}
