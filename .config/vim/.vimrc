" VIMRC
" settings for vim

" say that the color syntax could be better in tmux in tty
if $TERM == 'linux'
    echo "why did you struggle in tty ... because you wanna improve ? (type ENTER)"
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set runtimepath^=$XDG_CONFIG_HOME/vim
set runtimepath+=$XDG_DATA_HOME/vim
set runtimepath+=$XDG_CONFIG_HOME/vim/after

set packpath^=$XDG_DATA_HOME/vim,$XDG_CONFIG_HOME/vim
set packpath+=$XDG_CONFIG_HOME/vim/after,$XDG_DATA_HOME/vim/after

let g:netrw_home = $XDG_DATA_HOME."/vim"
call mkdir($XDG_DATA_HOME."/vim/spell", 'p')

set backupdir=$XDG_STATE_HOME/vim/backup | call mkdir(&backupdir, 'p')
set directory=$XDG_STATE_HOME/vim/swap   | call mkdir(&directory, 'p')
set undodir=$XDG_STATE_HOME/vim/undo     | call mkdir(&undodir,   'p')
set viewdir=$XDG_STATE_HOME/vim/view     | call mkdir(&viewdir,   'p')

if !has('nvim') | set viminfofile=$XDG_STATE_HOME/vim/viminfo | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim plug
call plug#begin('~/.vim/plugged')

" folder explorer
Plug 'preservim/nerdtree'
if $TERM != 'linux'
    " show git status on the folder explorer
    Plug 'Xuyuanp/nerdtree-git-plugin'
    " nice icons on the folder explorer
    Plug 'ryanoasis/vim-devicons'
endif
" open terminal with alt+=
Plug 'skywind3000/vim-terminal-help'
" screensaver with :ScreenSaver
Plug 'itchyny/screensaver.vim'
" try to bring colorscheme to all terminal
Plug 'godlygeek/csapprox'
" last used files with :MRU
Plug 'yegappan/mru'
" colorscheme base16
Plug 'chriskempson/base16-vim'

" tabs file at the bottom
Plug 'pacha/vem-tabline'
" quit nicely all buffer with :Sayonara
Plug 'mhinz/vim-sayonara'

" status line
Plug 'vim-airline/vim-airline'
" status line theme
Plug 'vim-airline/vim-airline-themes'

" sign colummn
if $TERM != 'linux'
    Plug 'mhinz/vim-signify'
else
    Plug 'airblade/vim-gitgutter'
endif

" epitech header
Plug 'Heliferepo/VimTek', { 'for': ['c', 'cpp', 'h'] }

" generate doxygen doc
Plug 'vim-scripts/DoxygenToolkit.vim', { 'for': ['c', 'cpp', 'h'] }

" underline world cursor
Plug 'itchyny/vim-cursorword'
" multiple line cursor with ctrl+n <select> ctrl+n
Plug 'terryma/vim-multiple-cursors'
" close ' [ ( { " auto
Plug 'jiangmiao/auto-pairs'
" show pairs colors for ' [ { ( "
Plug 'luochen1990/rainbow'
" better hightligh
Plug 'bfrg/vim-cpp-modern', { 'for': ['c', 'cpp', 'h'] }
" show trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
" open pdf on vim
Plug 'rhysd/open-pdf.vim'
" file content search
Plug 'wincent/ferret'
" ctrl+hjkl to move line
Plug 'matze/vim-move'
" highligh letter to go with f + letter
Plug 'unblevable/quick-scope'
" grammar check :GrammarousCheck
Plug 'rhysd/vim-grammarous'
" auto-save for some type
Plug '907th/vim-auto-save'
" echo function doc
Plug 'Shougo/echodoc.vim'

" auto completion general purpose
Plug 'tabnine/YouCompleteMe'
" auto completion for dart
Plug 'natebosch/vim-lsc', { 'for': ['dart'] }
Plug 'natebosch/vim-lsc-dart', { 'for': ['dart'] }
" completion for vim commands
Plug 'gelguy/wilder.nvim'

" syntax dart
Plug 'dart-lang/dart-vim-plugin', { 'for': ['dart'] }
" syntax vlang
Plug 'ollykel/v-vim'

" syntax check
"Plug 'scrooloose/syntastic'
" enter git commands in vim with :Git <commands>
Plug 'tpope/vim-fugitive'
" add / commit in a buffer
Plug 'jreybert/vimagit'

if filereadable("/bin/ctags")
    " tagbar at the right
    Plug 'preservim/tagbar'
endif
if filereadable("/bin/cargo")
    " useful utility to search something with :Clap
    Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary'  }
else
    Plug 'liuchengxu/vim-clap'
endif

call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" settings

" encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" highlight cursor line
autocmd BufWinEnter * set cursorline
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" fffffast
set ttyfast
set lazyredraw

" terminal name
set title
set titlestring=%f

" tabs
set hidden

" ruler
set ruler
set colorcolumn=80

" line number
set number
set relativenumber

" show hidden character
set list
set listchars=eol:$,tab:\ \
" term color to 256
set t_Co=256
" color syntax
syntax on
" no syntax for line > 1024
set synmaxcol=1024
" background
set background=dark
" colorscheme base16
colorscheme base16-atelier-forest

" nowrap line
set nowrap

" tab file completion
set wildignore=*.docx,*.jpg,*.gif,*.pyc,*.o,*.a,*.odt

" menucompletion
set completeopt=menu,menuone,noselect
set completeopt-=preview

" default shell
if filereadable('/bin/zsh')
    set shell=/bin/zsh
endif

" set mouse for alacritty
if $TERM == 'alacritty'
    set ttymouse=sgr
endif
" get mouse
if $TERM != 'linux'
    set mouse=a
endif

" search
" no highligh search after exit
set nohlsearch
set ignorecase
set smartcase
set showmatch
set incsearch

" tab/space settings
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" custom function

" have an 'I' cursor
function! EnterCursorBar()
    exec ':! echo -e -n "\x1b[\x36 q"'
endfunction
command! EnterCursorBar call EnterCursorBar()

" execute normatrix (my Epitech C coding style checker)
" you may update the command if you dont have the same path
function! NorMatrix()
    term ++shell $HOME/.src/NorMatrix/exec.sh
endfunction
command! NorMatrix call NorMatrix()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" keybinding
let mapleader = ";"

" excute the normatrix function with <F4>
map <F4> :<C-U>NorMatrix<CR>

" save the file with Ctrl+s
nnoremap <C-s> <Esc>:w<CR>
inoremap <C-s> <Esc>:w<CR>i

" exit with Ctrl+q
nnoremap <C-q> <Esc>:q<CR>
inoremap <C-q> <Esc>:wq<CR>

" navigate tab
nmap <leader><left> <Plug>vem_prev_buffer-
nmap <leader><p> <Plug>vem_prev_buffer-
nmap <leader><right> <Plug>vem_next_buffer-
nmap <leader><n> <Plug>vem_next_buffer-
nmap <Tab> <Plug>vem_next_buffer-

" move line
nmap <C-k> <Plug>MoveLineUp
nmap <C-j> <Plug>MoveLineDown
vmap <C-k> <Plug>MoveBlockUp
vmap <C-j> <Plug>MoveBlockDown
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
let g:airline_theme = 'base16'
let g:airline_left_sep = '>'
let g:airline_right_sep = '<'
let g:airline_inactive_collapse = 1
let g:airline_highlighting_cache = 0
let g:airline#parts#ffenc#skip_expected_string ='utf-8[unix]'
let g:airline_stl_path_style = 'full'
let g:airline#extensions#cursormode#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline_powerline_fonts = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_global_ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_semantic_triggers = { 'c': ['->', '.', 're!\w{2}'] }
let g:ycm_add_preview_to_completeopt = 0
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore = ['\.o$', '\.a$', '__pycache__$']
let NERDTreeWinSize = 25
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" devicon
if $TERM != 'linux'
    let g:webdevicons_enable_nerdtree = 1
    let g:webdevicons_conceal_nerdtree_brackets = 1
    let g:webdevicons_enable_airline_statusline = 1
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Screensaver
let g:screensaver_password = 1
" not serious password
call screensaver#source#password#set(sha256('vim'))
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rainbow
let g:rainbow_active = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mru
let g:MRU_File = $HOME.'/.vim/.vim_mru_files'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open-pdf
" because i dont want another .hidden folder in $HOME
let g:pdf_cache_dir = $HOME.'/.vim/.open-pdf.vim.cache'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-cpp-modern
let g:cpp_function_highlight = 1
let g:cpp_member_highlight = 1
let g:cpp_simple_highlight = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntastic
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_enable_signs = 1
"let g:syntastic_echo_current_error = 1
"let g:syntastic_c_compiler_options = ' -Wall -Wextra -Wpedantic'
"let g:syntastic_c_include_dirs = [ "lib/include", "include", "../include", "../lib/include"]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tagbar
if filereadable("/bin/ctags")
    let g:tagbar_sort = 0
    let g:tagbar_compact = 1
    let g:tagbar_show_tag_linenumbers = 1
    let g:tagbar_file_size_limit = 10000
    let g:tagbar_wrap = 1
    let g:tagbar_show_tag_count = 1
    let g:tagbar_indent = 1
    let g:tagbar_width = min([30, winwidth(0) / 5])
    let g:tagbar_autoshowtag = 1
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" clap
let g:clap_layout = { 'relative': 'editor' }
let g:clap_theme = 'material_design_dark'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" wilder
call wilder#setup({'modes': [':', '/', '?']})
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto save
let g:auto_save = 1
let g:auto_save_events = ["InsertLeave", "TextChanged"]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fardo
let g:far#ignore_files = ['.gitignore']
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" echodoc
let g:echodoc#type = 'echo'
set noshowmode
let g:echodoc_enable_at_startup = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-move
let g:move_map_keys = 0
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
