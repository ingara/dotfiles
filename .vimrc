" vim:foldmethod=marker:foldlevel=0

set nocompatible              " be iMproved, required
filetype off                  " required

"{{{ Plugins

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-vinegar'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'pangloss/vim-javascript'
Bundle 'plasticboy/vim-markdown'
Bundle 'tpope/vim-surround'
Bundle 'chriskempson/base16-vim'
Bundle 'junegunn/goyo.vim'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"}}}

"{{{ Misc
set ruler                       " Show line and column numbers in status bar
set mouse=a                     " Enable the use of the mouse.
set backspace=indent,eol,start  " Allow backspacing over everything in insert mode
set encoding=utf-8              " Best encoding is best
set autoread                    " Watch for file changes
set number                      " Show line numbers
set autochdir                   " cd into the current file's directory
set lazyredraw                  " Don't redraw unless we have to
set laststatus=2                " Required for Powerline
"}}}

"{{{ Plugin settings
let g:NERDTreeWinSize=25        " Slightly narrower nerd tree
let g:airline_powerline_fonts=1 " Nice fonts for airline
let g:airline_detect_modified=1 " Visualize modified files
"}}}

"{{{ Backup and swap
" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif
"}}}

"{{{ Searching
set hlsearch                    " Highlight search matches 
set incsearch                   " Incremental search matching
set ignorecase                  " Ignore case when searching
set smartcase                   " Don't ignore case when search pattern contains upper case characters
"}}}

"{{{ Whitespace stuff
set autoindent                  " When starting a new line, use the same indent as the current one
set tabstop=4                   " 4 spaces for tabs
set shiftwidth=4                " 4 spaces for each (auto)indent
set softtabstop=4               " Make spaces feel like tabs
set expandtab                   " Spaces for tabs
set nowrap                      " Don't soft wrap long lines
set list                        " Show invisible characters
set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮  " ... but only show tabs and trailing whitespace
"}}}

"{{{ Look and feel
set scrolloff=3             " Keep at least 3 lines above/below caret
set sidescrolloff=3         " ... and 3 to the left/right
syntax on                   " Syntax highlighting yay
set background=dark         " When set to "dark", Vim will try to use colors that look
                            " good on a dark background. When set to "light", Vim will
                            " try to use colors that look good on a light background.
                            " Any other value is illegal.
set foldenable              " Enable folds by default
set foldmethod=syntax       " Fold via syntax of files
set foldlevelstart=99       " Open all folds by default
"}}}

"{{{ Key mappings

" Space for president
let mapleader = "\<Space>"

" Left/right arrow keys to switch buffers
nnoremap <left> :bprev<CR>
nnoremap <right> :bnext<CR>

" Up/down arrow keys to switch tabs
nnoremap <up> :tabnext<CR>
nnoremap <down> :tabprev<CR>

" Move cursor in insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>
inoremap <C-k> <up>
inoremap <C-j> <down>

" Easy split window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Split windows with leader + v/s
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s

" Space to dismiss highlighting
nnoremap <CR> :noh<CR><CR>

" Keep search matches in the middle of the window and pulse the line when
" moving to them.
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" Copy and paste from system clipboard with y and p
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Map Goyo
nnoremap <Leader>g :Goyo<CR>

" Toggle Nerd Tree with Ctrl-E
map <C-E> :NERDTreeToggle<CR>
"}}}
