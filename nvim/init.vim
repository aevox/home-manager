" This must be first, because it changes other options as side effect
set nocompatible

filetype off


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set show matching parenthesis
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=1
" Ignore case when searching
set ignorecase
" Ignore case if search pattern is all lowercase, case-sensitive otherwise
set smartcase
" Insert tabs on the start of a line according to shiftwidth, not tabstop
set smarttab
" Highlight search terms
set hlsearch
" Show search matches as you type
set incsearch


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
" Use spaces instead of tabs
set expandtab
" Always set autoindenting on
set autoindent
" Copy the previous indentation on autoindenting
set copyindent
" Use multiple of shiftwidth when indenting with '<' and '>'
set shiftround
" Don't wrap lines
set nowrap
" Number of spaces to use for autoindenting
set shiftwidth=4
" A tab is four spaces
set tabstop=4
" Enable indent
filetype indent on
" Disable auto-comments
autocmd BufNewFile,BufRead,FileType * setlocal formatoptions-=cro
" Show trailing spaces
set list
set listchars=trail:•,extends:#,nbsp:.,tab:\ \ ,


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set timeoutlen=1000
set ttimeoutlen=0
" Always show line numbers
set number
" This allows buffers to be hidden if you've modified a buffer.
set hidden
" Always show current position
set ruler
" Height of the command bar
set cmdheight=1
" Remember more commands and search history
set history=1000
" Use many muchos levels of undo
set undolevels=1000
" Don't beep
set visualbell
" Don't beep
set noerrorbells
" Show cmd
set showcmd
" Visual autocomplete for command menu
set wildmenu
set wildignore=*.swp,*.bak,*.pyc,*.class
" Don't redraw when don't have to
set lazyredraw
" Keep at least 5 lines above/below
set scrolloff=5
" Keep at least 5 lines left/right
set sidescrolloff=5
" We have a fast terminal
set ttyfast
" Disable mouse in terminal
if !has('gui_running')
    set mouse=
endif
" Disable blinking when we reach the first line
autocmd GUIEnter * set vb t_vb=
autocmd VimEnter * set vb t_vb=
" Highlight current line number
set cursorline


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2

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

" Fix background color on SignColumn for GitGutter
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=yellow


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

" Check the code with syntastic
nnoremap <silent> cc :SyntasticCheck<cr> :Errors<cr>
nnoremap <silent> cq :lclose<cr>
nnoremap <silent> cp :lprevious<cr>
nnoremap <silent> cn :lnext<cr>

" Strip trailing whitespace
nnoremap <silent> <leader>s :call StripTrailingWhitespaces()<cr>

" Open file/word searcher with fzf-vim plugin
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>F :Ag<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Language specific configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup LanguageConfiguration
    autocmd!

    autocmd FileType plaintex      setlocal filetype=tex

    autocmd FileType css           setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType cue           setlocal noexpandtab tabstop=4 shiftwidth=4 listchars=tab:>.,
    autocmd FileType go            setlocal noexpandtab tabstop=4 shiftwidth=4
    autocmd FileType html,xml      setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType java          setlocal noexpandtab formatprg=par\ -w80\ -T4
    autocmd FileType javascript    setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType make          setlocal noexpandtab nolist
    autocmd FileType php           setlocal formatprg=par\ -w80\ -T4
    autocmd FileType python        setlocal colorcolumn=79 completeopt-=preview listchars=tab:>.,
    autocmd FileType ruby          setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType sh,zsh        setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType verilog       setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType vue           setlocal tabstop=2 shiftwidth=2 softtabstop=2
    autocmd FileType yaml          setlocal tabstop=2 shiftwidth=2 softtabstop=2 commentstring=#\ %s
    autocmd FileType sql           setlocal tabstop=2 shiftwidth=2 softtabstop=2

    autocmd FileType markdown,mkd  call Prose() | call HugoMarkdown()
    autocmd FileType rst           call Prose() | setlocal tabstop=4 shiftwidth=4 softtabstop=4
    autocmd FileType text,tex      call Prose()
augroup END


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


"""
" Handle some specific highlight for Hugo
"""

function! HugoMarkdown()
    syn region hugoFrontmatter start='^+++$' end='^+++$'
    syn match hugoShortcode '{{.*}}'
    syn region hugoHighlight matchgroup=hugoShortcode start='{{<highlight.*>}}' end='{{</highlight>}}'

    hi link hugoShortcode Statement
    hi link hugoHighlight markdownCode
    hi link hugoFrontmatter Comment
endfunction

" https://bepo.fr/wiki/Vim

" {W} -> [É]
" ——————————
" On remappe W sur É :
noremap é w
noremap É W
" Corollaire: on remplace les text objects aw, aW, iw et iW
" pour effacer/remplacer un mot quand on n’est pas au début (daé / laé).
onoremap aé aw
onoremap aÉ aW
onoremap ié iw
onoremap iÉ iW
" Pour faciliter les manipulations de fenêtres, on utilise {W} comme un Ctrl+W :
noremap w <C-w>
noremap W <C-w><C-w>

" [HJKL] -> {TSRN}
" ————————————————
" {tn} = « gauche / droite »
noremap t h
noremap n l
" {ts} = « haut / bas »
noremap s j
noremap r k
" {CR} = « haut / bas de l'écran »
noremap T H
noremap N L
" {TS} = « joindre / aide »
noremap S J
noremap R K
" Corollaire : repli suivant / précédent
noremap zs zj
noremap zr zk

" {HJKL} <- [TSRN]
" ————————————————
" {J} = « substitute with new text »                        (j = character, J = Line)
noremap j s
noremap J S
" {L} = « repeat last search »                              (l = next, L = previous)
noremap l n
noremap L N
" {H} = « find character after cursor in current lines
"         cursor moves to just before found character »     (h = next, H = previous)
noremap h t
noremap H T
" {K} = « Substitue »                                       (k = caractère, K = ligne)
noremap k r
noremap K R
" Corollaire : correction orthographique
noremap ]k ]r
noremap [k [r

" Désambiguation de {g}
" —————————————————————
" ligne écran précédente / suivante (à l'intérieur d'une phrase)
noremap gs gk
noremap gt gj
" onglet précédent / suivant
noremap gb gT
noremap gé gt
" optionnel : {gB} / {gÉ} pour aller au premier / dernier onglet
noremap gB :exe "silent! tabfirst"<CR>
noremap gÉ :exe "silent! tablast"<CR>
" optionnel : {g"} pour aller au début de la ligne écran
noremap g" g0

" <> en direct
" ————————————
noremap « <
noremap » >

" Remaper la gestion des fenêtres
" ———————————————————————————————
noremap ws <C-w>j
noremap wr <C-w>k
noremap wt <C-w>h
noremap wn <C-w>l
noremap wd <C-w>c
noremap wo <C-w>s
noremap wp <C-w>o
noremap w<SPACE> :split<CR>
noremap w<CR> :vsplit<CR>
