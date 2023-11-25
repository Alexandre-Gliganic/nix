{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      battery = {
        disabled = true;
      };
    };
  };
}
