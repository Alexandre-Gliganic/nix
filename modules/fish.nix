{ pkgs, ... }:
{
  programs.fish = {
    plugins = [
      {
        name = "autopair";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "main";
          sha256 = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
        };
      }
      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "patrickf1";
          repo = "fzf.fish";
          rev = "main";
          sha256 = "sha256-lxQZo6APemNjt2c21IL7+uY3YVs81nuaRUL7NDMcB6s=";
        };
      }
      {
        name = "colored-man-pages.fish";
        src = pkgs.fetchFromGitHub {
          owner = "patrickf1";
          repo = "colored_man_pages.fish";
          rev = "main";
          sha256 = "sha256-ii9gdBPlC1/P1N9xJzqomrkyDqIdTg+iCg0mwNVq2EU=";
        };
      }

    ];

    shellInit = ''
      export BAT_THEME="Sublime Snazzy"
      fzf_configure_bindings
      set -x PATH "$PATH:$HOME/.config/yarn/global/node_modules/.bin"
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';

    functions = {
      # Ansible
      ap-apply = { description = "ansible-playbook apply"; body = "ansible-playbook -D $argv"; wraps = "ansible-playbook"; };
      ap-vault-apply = { description = "ansible-playbook apply --ask-vault-pass"; body = "ansible-playbook -D --ask-vault-pass $argv"; wraps = "ansible-playbook"; };
      ap-check = { description = "ansible-playbook check"; body = "ansible-playbook -CD $argv"; wraps = "ansible-playbook"; };
      ap-vault-check = { description = "ansible-playbook check --ask-vault-pass"; body = "ansible-playbook -CD --ask-vault-pass $argv"; wraps = "ansible-playbook"; };
      ap-with-bc = { description = "ansible-playbook bc"; body = "ansible-playbook -D --ask-vault-pass -i hosts-no-root.ini $argv"; wraps = "ansible-playbook"; };


      # Docker
      dc = { description = "docker compose"; body = "docker compose $argv"; wraps = "docker compose"; };
      dcd = { description = "docker compose down"; body = "docker compose down $argv"; wraps = "docker compose"; };
      dcu = { description = "docker compose up -d"; body = "docker compose up -d $argv"; wraps = "docker compose"; };
      dcuf = { description = "docker compose up -d --force-recreate"; body = "docker compose up -d --force-recreate $argv"; wraps = "docker compose"; };


      # Git
      ## Git add
      ga = { description = "git add"; body = "git add $argv"; wraps = "git add"; };

      ## Git commit
      gcim = { description = "git commit -m"; body = "git commit -m $argv"; wraps = "git commit"; };

      ## Git push
      gp = { description = "git push"; body = "git push $argv"; wraps = "git push"; };
      gpt = { description = "git push --tags"; body = "git push --tags"; wraps = "git push"; };
      gpft = { description = "git push --follow-tags"; body = "git push --follow-tags $argv"; wraps = "git push"; };
      gpmr = { description = "git push and open merge request on specific branch"; body = "git push -o merge_request.create -o merge_request.target=$argv[1]"; wraps = "git push"; };

      # Git diff
      gd = { description = "git diff"; body = "git diff $argv"; wraps = "git diff"; };
      gds = { description = "git diff --staged"; body = "git diff --staged $argv"; wraps = "git diff"; };

      ## Git tag
      gt = { description = "git tag"; body = "git tag"; wraps = "git tag"; };
      gtf-epita = {
        description = "git tag epita format";
        body = ''
          set current_dir (pwd)
          set dir_name (basename $current_dir)
          git tag -a exercice-$dir_name-v$argv[1] -m $argv[1]
        '';
      };
      gtf = {
        description = "git tag format";
        body = ''
          git tag -a v$argv[1] -m "v$argv[1]"
        '';
        wraps = "git tag";
      };

      ## Git others
      gst = { description = "git status"; body = "git status"; wraps = "git status"; };
      gls = { description = "git ls-files"; body = "git ls-files"; wraps = "git ls-files"; };
      gra = { description = "git remote add"; body = "git remote add $argv"; wraps = "git remote"; };

      ## Git log
      gll = { description = "Git log custom"; body = "git log --color --graph --pretty=format:'%C(bold red)%h%Creset %C(bold green)%G?:%Creset%C(auto)%d%Creset %s %C(bold cyan)(%cr)%Creset' | head -30"; };
      glld = { description = "Git log custom"; body = "git log --color --graph --pretty=format:'%C(bold red)%h%Creset %C(bold green)%G?:%Creset%C(auto)%d%Creset %s %C(blue)%ad%Creset %C(bold yellow)<%an> %Creset'"; };
      gllf = { description = "Git log custom full"; body = "git log --color --graph --pretty=format:'%C(bold red)%h%Creset %C(bold green)%G?:%Creset%C(auto)%d%Creset %s %C(bold cyan)(%cr)%Creset'"; };


      # Kubernetes
      k = { description = "Kubectl"; body = "kubectl $argv"; wraps = "kubectl"; };
      kcx = { description = "Kubectx"; body = "kubectx $argv"; wraps = "kubectx"; };
      kns = { description = "Kubens"; body = "kubens $argv"; wraps = "kubens"; };


      # Nix
      garbage = { description = "Garbage nix"; body = "sudo nix-collect-garbage -d"; wraps = "nix-collect-garbage"; };
      nixfmt = { description = "Launch nixpkgs-fmt"; body = "nixpkgs-fmt $argv"; wraps = "nixpkgs-fmt"; };
      nixsh = { description = "Launch nix shell with fish"; body = "nix-shell -p $argv"; wraps = "nix-shell"; };
      optimize = { description = "Optimize nix-store"; body = "sudo nix-store --optimize"; wraps = "nix-store"; };
      update = { description = "Update nix-channel and reload"; body = "sudo nix-channel --update"; wraps = "nix-channel"; };
      switch-hm = { description = "Switch home-manger config"; body = "nixfmt . && home-manager switch --flake .#$argv[1] && fish"; wraps = "home-manager switch"; };
      switch-nixos = { description = "Switch nixos config"; body = "nixfmt . && sudo nixos-rebuild switch --flake .#$argv[1]"; wraps = "nixos-rebuild switch"; };


      # Others
      catcp = { description = "Cat and Copy"; body = "cat $argv | clipboard"; };
      cheatsh = { description = "Curl cheat.sh"; body = "curl cheat.sh/$argv[1]"; };
      grep-in = { description = "grep recursively in current directory"; body = "grep -nrie $argv[1]"; };
      mkcd = { description = "Make a directory tree and enter it"; body = "mkdir -p $argv[1]; and cd $argv[1]"; };
      pwdf = { description = "Get path of file"; body = "realpath $argv"; wraps = "realpath"; };
      sshl = { description = "List ssh"; body = "ssh-add -L"; wraps = "ssh-add"; };
      sshlcp = { description = "List ssh and copy"; body = "sshl | clipboard"; };
      sshkeygencp = { description = "Copy generate ssh key command"; body = "echo ssh-keygen -a 100 -t ed25519 | clipboard"; };
      tf = { description = "tofu"; body = "tofu $argv"; wraps = "tofu"; };
      terraform = { description = "Terraform"; body = "tofu $argv"; wraps = "tofu"; };
      #rm = { description = "Rm to bin"; body = "trash -i --trash-dir=$HOME/.Trash/ $argv"; };
    };
  };
}
