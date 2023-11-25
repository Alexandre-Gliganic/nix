{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alacritty
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
    go
    glow
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
    mtr
    neofetch
    nix
    nix-prefetch-git
    nixpkgs-fmt
    nodejs_20
    novnc
    nmap
    openssh
    python310Packages.pip
    python311
    tcptraceroute
    terraform
    trash-cli
    tree
    vault
    watch
    wget
    yarn
    zoxide
  ];
}
