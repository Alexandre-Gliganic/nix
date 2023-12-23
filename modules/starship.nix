{ pkgs, ... }:

{
  programs.starship = {
    settings = {
      battery = {
        disabled = true;
      };
      kubernetes = {
        disabled = false;
        detect_folders = [ "k8s" ];
      };
      os = {
        disabled = true;
        symbols = {
          Linux = " ";
          Windows = " ";
          Macos = " ";
          NixOS = " ";
        };
      };
    };
  };
}
