{ config, pkgs, lib, ... }:
let
  vimrc = builtins.readFile ./init.vim;
  bepo = builtins.readFile ./bepo.vim;
  coc = builtins.readFile ./coc.vim;
in
{
  home.sessionVariables = { EDITOR = "nvim"; };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;
    withPython3 = true;
    coc = {
      enable = true;
      settings = { "suggest.noselect" = true;
        "suggest.enablePreview" = true;
        "suggest.enablePreselect" = false;
        "suggest.disableKind" = true;
        "diagnostic.displayByAle" = true;
        "spell-checker.enable" = false;
        "go.goplsPath" = lib.mkAfter "${config.home.homeDirectory}/.nix-profile/bin/gopls";
      };
    };
    plugins = with pkgs.vimPlugins; [
      # Language plugins
      coc-pyright
      coc-go
      coc-git
      coc-docker
      coc-sh
      coc-vimlsp
      coc-css
      coc-html
      coc-json
      coc-toml
      coc-yaml
      coc-rls
      coc-cmake
      # Gui
      coc-prettier
      coc-pairs

      vimtex
      vim-cue
      vim-nix
      vim-terraform

      suda-vim
      plenary-nvim
      telescope-nvim
      fugitive

      # Themes
      {
        plugin = kanagawa-nvim;
        type = "lua";
        config = ''
          require('kanagawa').setup({
            transparent = true
          })
        '';
      }
      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = ''
          require('catppuccin').setup({
            transparent_background = true
          })
        '';
      }
      {
        plugin = gruvbox;
        config = ''
          let g:gruvbox_transparent_bg = 1
        '';
      }
      {
        plugin = ale; # syntax checker
        config = ''
          let g:ale_disable_lsp = 1
          let g:ale_virtualtext_cursor = 'disabled'
        '';
      }
      {
        plugin = nerdtree;
        config = ''
          nmap <F3> :NERDTreeToggle<CR>
        '';
      }
      {
        plugin = tagbar;
        config = ''
          nmap <F4> :TagbarToggle<CR>
        '';
      }
      {
        plugin = indentLine;
        config = ''
          let g:indentLine_enabled = 0
          nmap <F5> :IndentLinesToggle<CR>
        '';
      }
      {
        plugin = vim-terraform;
        config = ''
          let g:terraform_fmt_on_save = 1
        '';
      }
      {
        plugin = vim-go;
        config = ''
          let g:go_highlight_functions = 1
          let g:go_highlight_methods = 1
          let g:go_highlight_structs = 1
          let g:go_highlight_operators = 1
          let g:go_highlight_build_constraints = 1
          if executable('goimports')
            let g:go_fmt_command = 'goimports'
          endif'';
      }
      {
        plugin = vim-pencil;
        config = ''
          let g:pencil#wrapModeDefault = 'soft'
          let g:pencil#autoformat = 0
          let g:pencil#conceallevel = 0
        '';
      }
      vim-airline-themes
      {
        plugin = vim-airline;
        config = ''
          let g:airline_theme = 'onedark'
          let g:airline#extensions#tabline#enabled = 1
          let g:airline#extensions#tabline#left_sep = ""
          let g:airline#extensions#tabline#left_alt_sep = ""
          let g:airline#extensions#tabline#right_sep = ""
          let g:airline#extensions#tabline#right_alt_sep = ""
        '';
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local builtin = require('telescope.builtin')
          vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
          vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
          vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
          vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
          vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        '';
      }
    ];
    extraConfig = ''
      ${bepo}
      ${vimrc}
      ${coc}

      " Reset cursor to blinking block when exiting neovim
      au VimLeave,VimSuspend * set guicursor=a:blinkon0
    '';
  };
}
