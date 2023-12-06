{ pkgs, ... }:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [ vim-nix vim-terraform ansible-vim copilot-vim vim-airline vim-better-whitespace ];
    vimAlias = true;
    extraConfig = ''
      set mouse=a
      syntax on
      " set textwidth=80
      set nowrap
      set shiftwidth=4
      set softtabstop=-1
      " set expandtab
      set autoindent
      set number
      set colorcolumn=81
      " set colorcolumn=+1
      map f w
    '';
  };
}
