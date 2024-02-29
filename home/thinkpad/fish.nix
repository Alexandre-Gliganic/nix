{ pkgs, ... }:
{
  programs.fish = {
    functions = {
      clipboard = { description = "Copy to clipboard"; body = "xsel -ib"; wraps = "xsel"; };
      icat = { description = "print image in terminal"; body = " kitty +kitten icat $argv "; wraps = "icat"; };
      ssh = { description = "ssh to a host with kitty"; body = " kitty +kitten ssh $argv "; wraps = "ssh"; };
      vpn = { description = "Connect or disconnect to VPN"; body = "nmcli connection $argv[1] $argv[2]"; wraps = "nmcli connection $argv[1]"; };
    };
  };
}
