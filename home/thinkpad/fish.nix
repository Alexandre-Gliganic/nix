{ pkgs, ... }:
{
  programs.fish = {
    functions = {
      ssh = { description = "ssh to a host with kitty"; body = " kitty +kitten ssh $argv "; };
      icat = { description = "print image in terminal"; body = " kitty +kitten icat $argv "; };
    };
  };
}
