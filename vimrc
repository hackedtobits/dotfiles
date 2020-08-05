" COLORS
syntax enable
"set background=light
"let g:solarized_termcolors=256
"colorscheme solarized
" MISC
set ttyfast                     " faster redraw
set backspace=indent,eol,start
" SPACES & TABS
set tabstop=4           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=4       " 4 space tab
set shiftwidth=4
filetype indent on
filetype plugin on
set autoindent
" UI LAYOUT
set number              " show line numbers
set showcmd             " show command in bottom bar
set nocursorline          " highlight current line
set wildmenu
set showmatch           " higlight matching parenthesis
" SEARCHING
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
" STATUS
set laststatus=2
" LAUNCH CONFIG
runtime! debian.vim
set nocompatible
