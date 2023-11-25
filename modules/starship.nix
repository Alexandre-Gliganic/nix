{ pkgs, ... }:

{
  programs.starship = {
    settings = {
      battery = {
        disabled = true;
      };
    };
  };
}
