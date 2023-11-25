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
          repo = "colored_man_pages";
          rev = "main";
          sha256 = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
        };
      }

    ];

    #loginShellInit = ''
    #  . ~/.nix-profile/etc/profile.d/nix.fish
    #'';
    interactiveShellInit = ''
      set -x PATH "$PATH:$HOME/.config/yarn/global/node_modules/.bin"
    '';
    shellInit = ''
      export BAT_THEME="Sublime Snazzy"
      fzf_configure_bindings
      any-nix-shell fish --info-right | source
    '';

    functions = {
      ap-apply = { description = "ansible-playbook apply"; body = "ansible-playbook -D $argv"; };
      ap-vault-apply = { description = "ansible-playbook apply --ask-vault-pass"; body = "ansible-playbook -D --ask-vault-pass $argv"; };
      ap-check = { description = "ansible-playbook check"; body = "ansible-playbook -CD $argv"; };
      ap-vault-check = { description = "ansible-playbook check --ask-vault-pass"; body = "ansible-playbook -CD --ask-vault-pass $argv"; };
      ap-with-bc = { description = "ansible-playbook bc"; body = "ansible-playbook -D --ask-vault-pass -i hosts-no-root.ini $argv"; };
      catcp = { description = "Cat and Copy"; body = "cat $argv | pbcopy"; };
      cheatsh = { description = "Curl cheat.sh"; body = "curl cheat.sh/$argv[1]"; };
      dc = { description = "docker compose"; body = "docker compose $argv"; };
      dcd = { description = "docker compose down"; body = "docker compose down $argv"; };
      dcu = { description = "docker compose up -d"; body = "docker compose up -d $argv"; };
      dcuf = { description = "docker compose up -d --force-recreate"; body = "docker compose up -d --force-recreate $argv"; };
      fetch-hm = { description = "Fetch home-manager"; body = "cd ~/nix && git pull && cp * ~/.config/home-manager/ && reload && cd -"; };
      ga = { description = "git add"; body = "git add $argv"; };
      garbage = { description = "Garbage nix"; body = "sudo nix-collect-garbage -d"; };
      gcim = { description = "git commit -m"; body = "git commit -m $argv"; };
      gll = { description = "Git log custom"; body = "git log --color --graph --pretty=format:'%C(bold red)%h%Creset %C(bold green)%G?:%Creset%C(auto)%d%Creset %s %C(bold cyan)(%cr)%Creset' | head -30"; };
      glld = { description = "Git log custom"; body = "git log --color --graph --pretty=format:'%C(bold red)%h%Creset %C(bold green)%G?:%Creset%C(auto)%d%Creset %s %C(blue)%ad%Creset %C(bold yellow)<%an> %Creset'"; };
      gllf = { description = "Git log custom full"; body = "git log --color --graph --pretty=format:'%C(bold red)%h%Creset %C(bold green)%G?:%Creset%C(auto)%d%Creset %s %C(bold cyan)(%cr)%Creset'"; };
      gls = { description = "git ls-files"; body = "git ls-files"; };
      gp = { description = "git push"; body = "git push $argv"; };
      gpmr = { description = "git push and open merge request on specific branch"; body = "git push -o merge_request.create -o merge_request.target=$argv[1]"; };
      gpft = { description = "git push --follow-tags"; body = "git push --follow-tags $argv"; };
      gra = { description = "git remote add"; body = "git remote add $argv"; };
      gra-gitlab = { description = "git remote add gitlab"; body = "git remote add gitlab $argv[1]"; };
      grd = { description = "git remote remove"; body = "git remote remove $argv[1]"; };
      gst = { description = "git status"; body = "git status"; };
      gt = { description = "git tag"; body = "git tag"; };
      grep-in = { description = "grep recursively in current directory"; body = "grep -nrie $argv[1]"; };
      hme = { description = "Edit home manager file"; body = "nvim ~/.config/home-manager/home.nix"; };
      k = { description = "Kubectl"; body = "kubectl $argv"; };
      mkcd = { description = "Make a directory tree and enter it"; body = "mkdir -p $argv[1]; and cd $argv[1]"; };
      nixfmt = { description = "Launch nixpkgs-fmt"; body = "nixpkgs-fmt $argv"; };
      nixfmthm = { description = "Format home manager file"; body = "nixpkgs-fmt ~/.config/home-manager/home.nix"; };
      nixsh = { description = "Launch nix shell with fish"; body = "nix-shell -p $argv"; };
      optimize = { description = "Optimize nix-store"; body = "sudo nix-store --optimize"; };
      pwdf = { description = "Get path of file"; body = "realpath $argv"; };
      push-hm = { description = "copy current home.nix and push to git"; body = "cd ~/nix && cp ~/.config/home-manager/* . && git add . && git commit -m $argv[1] && git push && cd -"; };
      reload = { description = "Reload home-manger config"; body = "nixfmthm && home-manager switch && fish"; };
      # rm = { description = "Rm to bin"; body = "trash -i --trash-dir=$HOME/.Trash/ $argv"; };
      sshkeygencp = { description = "Copy generate ssh key command"; body = "echo ssh-keygen -a 100 -t ed25519 | pbcopy"; };
      sshl = { description = "List ssh"; body = "ssh-add -L"; };
      sshlcp = { description = "List ssh and copy"; body = "sshl | pbcopy"; };
      tf = { description = "terraform"; body = "terraform $argv"; };
      update = { description = "Update nix-channel and reload"; body = "sudo nix-channel --update && reload"; };
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
      };
    };
  };

}
