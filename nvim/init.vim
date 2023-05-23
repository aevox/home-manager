"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set show matching parenthesis
set showmatch
" Ignore case when searching
set ignorecase
" Ignore case if search pattern is all lowercase, case-sensitive otherwise
set smartcase

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab
" Copy the previous indentation on autoindenting
set copyindent
" Round indent to multiple of 'shiftwidth'
set shiftround
" Number of spaces to use for autoindenting
set shiftwidth=4
" A tab is four spaces
set tabstop=4
" Show trailing spaces
set list
set listchars=trail:•,extends:#,nbsp:.,tab:\ \ ,

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Time in milliseconds to wait for a key code sequence to complete
set ttm=0
" Always show line numbers
set number
"  Display signs in the 'number' column
set scl=number
" Ignore those files in menus
set wildignore=*.swp,*.bak,*.pyc,*.class
" Keep at least 10 lines above/below
set scrolloff=10
" Keep at least 10 lines left/right
set sidescrolloff=10
" Highlight current line number
set cursorline
" Automatically show column sign
set signcolumn=number

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
if &t_Co >= 256 || has('gui_running')
    let g:rehash256 = 1
    silent! colorscheme gruvbox
endif

set background=dark

if &t_Co > 2 || has('gui_running')
    " Switch syntax highlighting on, when the terminal has colors
    syntax enable
endif

" Disable background color because it adds spaces in terminal
highlight Normal ctermbg=none

" Fix background color on SignColumn for coc-git
highlight SignColumn ctermbg=NONE
highlight lineNr ctermbg=NONE
highlight GruvboxRedSign ctermfg=Red ctermbg=NONE
highlight GruvboxGreenSign ctermfg=Green ctermbg=NONE
highlight GruvboxYellowSign ctermfg=Yellow ctermbg=NONE
highlight GruvboxBlueSign ctermfg=Blue ctermbg=NONE
highlight GruvboxPurple ctermfg=175 ctermbg=NONE
highlight GruvboxAquaSign ctermfg=108 ctermbg=NONE
highlight GruvboxOrangeSign ctermfg=208 ctermbg=NONE
highlight link CocGitAddedSign GruvboxGreenSign
highlight link CocGitChangedSign GruvboxYellowSign
highlight link CocGitRemovedSign GruvboxRedSign
highlight link CocGitTopRemovedSign GruvboxRedSign
highlight link CocGitChangeRemovedSign GruvboxOrangeSign

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ','

" Fast saving
nnoremap <silent> <leader>w :w!<cr>

" Hide highlight when <leader><cr> is pressed
nnoremap <silent> <leader><cr> :noh<cr>

" Close buffer
nnoremap <silent> <leader>q :GracefulQuit<cr>

" Fast moving between buffers
nnoremap <silent> <leader>t :bprevious<cr>
nnoremap <silent> <leader>n :bnext<cr>

" Strip trailing whitespace
nnoremap <silent> <leader>s :call StripTrailingWhitespaces()<cr>

" Open file/word searcher with fzf-vim plugin
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>F :Ag<cr>

" " Copy to clipboard
vnoremap  <leader>y  "+y<cr>
" " Paste from clipboard
nnoremap <leader>p "+p<cr>

" " Workaround for 'clipboard=autoselect', it copies mouse selection into
" * register
vmap <LeftRelease> "*ygv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""
" Set the current buffer in text mode
"""

function! Prose()
    call pencil#init()
    setlocal nocursorline
endfunction

command! -nargs=0 Prose call Prose()


"""
" Strip trailing whitespace in the current buffer
"""

function! StripTrailingWhitespaces()
    let l:winview = winsaveview()
    silent! %s/\s\+$//
    call winrestview(l:winview)
endfunction


"""
" Quit if their are no buffer open
"""

function! CountListedBuffers()
    let cnt = 0
    for nr in range(1,bufnr("$"))
        if buflisted(nr) && ! empty(bufname(nr))
            let cnt += 1
        endif
    endfor
    return cnt
endfunction

function! QuitIfNoBuffer(bang)
    if CountListedBuffers() <= 1
        if a:bang
            :quit!
        else
            :quit
        endif
    else
        if a:bang
            :bdelete!
        else
            :bdelete
        endif
    endif
endfunction

command -nargs=* -range -bang GracefulQuit call QuitIfNoBuffer(<bang>0)
