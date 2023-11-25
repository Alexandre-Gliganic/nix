{ config, pkgs, ... }:

{
  nix.settings.trusted-users = [ "alex" ];

  users.users.alex = {
    description = "Alex";
    isNormalUser = true;
    createHome = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII99FWFseu0Xurv3SJ/lGK0gQLeZbeUDlZQqWlD1r36m yubi-alex"
    ];
  };

}
