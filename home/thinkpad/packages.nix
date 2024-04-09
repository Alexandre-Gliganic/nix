{ pkgs, ... }:
let
  mkAlias = pkgsName: aliasName: pkgs.writeShellScriptBin "${aliasName}" ''
    ${pkgsName}
  '';
  chrome = mkAlias "${pkgs.google-chrome}/bin/google-chrome-stable" "chrome";
in
{
  home.packages = with pkgs; [
    ansible
    any-nix-shell
    apache-directory-studio
    awscli2
    bat
    bc
    chrome
    coreutils
    discord
    dnsutils
    fd
    feh
    flameshot
    font-awesome
    fzf
    gcc
    git-lfs
    glow
    go
    google-chrome
    htop
    inetutils
    ipcalc
    jdk17_headless
    jq
    kitty
    kubectl
    kubectx
    kustomize
    ldns
    lolcat
    lunarvim
    maven
    meslo-lgs-nf
    mtr
    neofetch
    nix
    nix-prefetch-git
    nixpkgs-fmt
    nload
    nmap
    nodejs_20
    novnc
    openssh
    opentofu
    python310Packages.pip
    python311
    stern
    tcptraceroute
    thunderbird
    tree
    unstable.jetbrains.idea-ultimate
    vault
    watch
    wget
    winbox
    wireshark
    xca
    yarn
    zoxide
  ];
}
