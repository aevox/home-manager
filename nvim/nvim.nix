{ config, pkgs, ... }:
let
  vimrc = builtins.readFile ./init.vim;
in
{
  home.sessionVariables = { EDITOR = "nvim"; };

  programs.neovim = let
    pastemode-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "pastemode-vim";
      version = "2019-11-13";
      src = pkgs.fetchFromGitHub {
        owner = "lightcode";
        repo = "PasteMode.vim";
        rev = "1046b1efc0a85ee18a0f8cdbcb3d14a1743c1a1b";
        sha256 = "0bp4rwhj08mjafcpn0f27im21gvndaa5yqfv9apar0lzqk3wwgnv";
      };
      meta.homepage = "https://github.com/lightcode/PasteMode.vim";
    };
    dockerfile-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "dockerfile-vim";
      version = "2021-11-06";
      src = pkgs.fetchFromGitHub {
        owner = "ekalinin";
        repo = "Dockerfile.vim";
        rev = "2a31e6bcea5977209c05c728c4253d82fd873c82";
        sha256 = "MiSGZ5MJ5g37szUuo8XCbuzuAcNBSqYY6hVa/WJwLDY=";
      };
      meta.homepage = "https://github.com/ekalinin/Dockerfile.vim";
    };
  in {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;
    coc = {
      enable = true;
      pluginConfig = ''
      inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
      inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
      inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
      inoremap <silent><expr> <cr> coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm() : "\<C-g>u\<CR>"

      " use <tab> to trigger completion and navigate to the next complete item
      function! CheckBackspace() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
      endfunction
      inoremap <silent><expr> <Tab>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()

        " use <c-space> for trigger completion
      inoremap <silent><expr> <c-space> coc#refresh()

      inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
      inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
'';
      settings = {
        "suggest.noselect" = true;
        "suggest.enablePreview" = true;
        "suggest.enablePreselect" = false;
        "suggest.disableKind" = true;
      };
    };
    plugins = with pkgs.vimPlugins; [

      dockerfile-vim
      suda-vim
      tagbar
      fzf-vim
      indentLine
      fugitive
      vimtex
#      {
#        plugin = YouCompleteMe;
#        config = ''
#          let g:ycm_gopls_binary_path = '${pkgs.gopls}/bin/gopls'
#          let g:ycm_auto_trigger = 1
#          let g:ycm_enable_inlay_hints = 1
#          let g:ycm_add_preview_to_completeopt = 0
#          let g:ycm_autoclose_preview_window_after_insertion = 1'';
#      }
      {
        plugin = nerdtree;
        config = "nmap <F3> :NERDTreeToggle<CR>";
      }
      {
        plugin = tagbar;
        config = "nmap <F4> :TagbarToggle<CR>";
      }
      {
        plugin = indentLine;
        config = ''
          let g:indentLine_enabled = 0
          nmap <F5> :IndentLinesToggle<CR>'';
      }

      # lightcode
      {
        plugin = pastemode-vim;
        config = "nnoremap <silent> <F2> :PasteModeToggle<cr>";
      }
      gruvbox
      vim-airline-themes
      vim-cue
      vim-gitgutter
      vim-nix

      {
        plugin = vim-terraform;
        config = "let g:terraform_fmt_on_save = 1";
      }
      {
        plugin = vim-markdown;
        config = "let g:vim_markdown_folding_disabled = 1";
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
          let g:pencil#conceallevel = 0'';
      }
      {
        plugin = syntastic;
        config = ''
          let g:syntastic_always_populate_loc_list = 1
          let g:syntastic_auto_loc_list = 2
          let g:syntastic_check_on_open = 1
          let g:syntastic_check_on_wq = 1
          " Here we can make check active or passive.
          " I made `rst` checking passive because it doesn't
          " handle Sphinx well.
          let g:syntastic_mode_map = {
              \ 'mode': 'active',
              \ 'active_filetypes': [],
              \ 'passive_filetypes': ['rst'] }
          let g:syntastic_error_symbol = '✗'
          let g:syntastic_warning_symbol = '⚠'
          let g:syntastic_python_checkers = ['flake8']
          let g:syntastic_go_checkers = ['go', 'golint', 'govet']
          let g:syntastic_javascript_checkers = ['jshint']
          let g:syntastic_yaml_checkers = ['yamllint']
          let g:syntastic_ansible_checkers = ['yaml/yamllint']
          let g:syntastic_sh_shellcheck_args = "-x"'';
      }
      {
        plugin = vim-airline;
        config = ''
          set noshowmode
          let g:airline_theme = 'bubblegum'
          let g:airline_skip_empty_sections = 1
          let g:airline#extensions#tabline#enabled = 1
          let g:airline#extensions#tabline#fnamemod = ':t'
          let g:airline#extensions#tabline#left_sep = ""
          let g:airline#extensions#tabline#left_alt_sep = ""
          let g:airline#extensions#tabline#right_sep = ""
          let g:airline#extensions#tabline#right_alt_sep = ""'';
      }
    ];
    extraConfig = ''
      ${vimrc}

      " Reset cursor to blinking "|" when exiting neovim
      au VimLeave,VimSuspend * set guicursor=a:ver25-blinkon0
      '';
  };
}
