{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ansible
    any-nix-shell
    awscli2
    bat
    coreutils
    dnsutils
    fd
    fzf
    gcc
    git-lfs
    glow
    go
    htop
    inetutils
    ipcalc
    jdk17_headless
    jq
    kubectl
    kustomize
    ldns
    lolcat
    maven
    mc
    mtr
    neofetch
    nix
    nix-prefetch-git
    nixpkgs-fmt
    nmap
    nodejs_20
    novnc
    openssh
    opentofu
    python310Packages.pip
    python311
    tcptraceroute
    trash-cli
    tree
    unstable.vault
    watch
    wget
    yarn
    zoxide
  ];
}
