" vim:foldmethod=marker:foldlevel=0

set nocompatible

"{{{ Plugins
if has('vim_starting')
    if &compatible
        set nocompatible               " Be iMproved
    endif

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'tpope/vim-sensible'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'groenewege/vim-less'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'junegunn/goyo.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'moll/vim-node'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'othree/javascript-libraries-syntax.vim'

call neobundle#end()

filetype plugin indent on
"}}}

"{{{ Misc
set mouse=a                     " Enable the use of the mouse.
set encoding=utf-8              " Best encoding is best
set number                      " Show line numbers
set autochdir                   " cd into the current file's directory
set lazyredraw                  " Don't redraw unless we have to

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"}}}

"{{{ Plugin settings
let g:NERDTreeWinSize=31                                    " Slightly narrower nerd tree
let g:airline_powerline_fonts=1                             " Nice fonts for airline
let g:airline_detect_modified=1                             " Visualize modified files
if executable('jsxhint')                                    " Use jsxhint if available
    let g:syntastic_javascript_checkers = ['jsxhint']
endif
let g:goyo_width=120                                        " Slightly wider goyo than default (80)
let g:neocomplete#enable_at_startup = 1                     " Enable Neocomplete
let g:neocomplete#enable_smart_case = 1                     " smartcase
let g:neocomplete#sources#syntax#min_keyword_length = 3     " Start matching on 3 characters

call unite#filters#matcher_default#use(['matcher_fuzzy'])   " Fuzzy matching in unite
call unite#custom#profile('default', 'context', { 'marked_icon':'✓'}) " Pretty icon for unite
let g:unite_source_history_yank_enable = 1                  " Enable searching yankring in unite
if executable('ag')                                         " Use ag for unite if it exists
    let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --hidden -g ""'
endif

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
set ignorecase                  " Ignore case when searching
set smartcase                   " Don't ignore case when search pattern contains upper case characters
"}}}

"{{{ Whitespace stuff
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
set splitright              " Horizontal splits open to the right
set splitbelow              " Vertical splits open below
"}}}

"{{{ Key mappings

" Space for president
let mapleader = "\<Space>"

" Left/right arrow keys to switch buffers
nnoremap <up> :bprev<CR>
nnoremap <down> :bnext<CR>

" Up/down arrow keys to switch tabs
nnoremap <right> :tabnext<CR>
nnoremap <left> :tabprev<CR>

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

" Dismiss highlighting with leader + /
nnoremap <silent> <Leader>/ :nohlsearch<Bar>:echo<CR>

" Keep search matches in the middle of the window and pulse the line when
" moving to them.
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" Copy and paste from system clipboard with y and p
vmap <Leader>y "+y
vmap <Leader>d "+d
vmap <Leader>p "+p
vmap <Leader>P "+P
nmap <Leader>p "+p
nmap <Leader>P "+P

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Map Goyo
nnoremap <Leader>g :Goyo<CR>

" Toggle Nerd Tree with Ctrl-E
map <C-E> :NERDTreeToggle<CR>

"{{{ Neocomplete

" Tab completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" Insert candidate and close popup
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
" Cancel completion
inoremap <expr><C-e> neocomplete#cancel_popup()
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-Space> neocomplete#complete_common_string()

" <BS>: close popup and delete backword char.
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" <C-e>: Cancel popup
inoremap <expr><C-e> neocomplete#cancel_popup()
"}}}
"{{{ Unite

" Find files including subfolders
nnoremap <leader>t :<C-u>Unite -buffer-name=files   -start-insert file_rec/async:!<cr>
" Find files in current folder
nnoremap <leader>f :<C-u>Unite -buffer-name=files   -start-insert file<cr>
" Find in yankring
nnoremap <leader>yr :<C-u>Unite -buffer-name=yank    history/yank<cr>
" Find buffers
nnoremap <leader>e :<C-u>Unite -buffer-name=buffer  buffer<cr>

" When in a unite buffer, close it from normal mode with Q or esc
function! s:unite_settings()
    nmap <buffer> Q <plug>(unite_exit)
    nmap <buffer> <esc> <plug>(unite_exit)
endfunction
autocmd FileType unite call s:unite_settings()
"}}}
"}}}

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
