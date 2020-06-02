    " vim:foldmethod=marker:foldlevel=0

let s:darwin = has('mac')
let s:windows = has("win32") || has("win16")
let s:ag = executable('ag')
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"{{{ Plugins

if s:windows
    call plug#begin('~/vimfiles/bundle')
else
    call plug#begin('~/.vim/plugged')
endif

  "{{{ Core
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-unimpaired'
    Plug 'terryma/vim-expand-region' "{{{
      vmap v <Plug>(expand_region_expand)
      vmap <C-v> <Plug>(expand_region_shrink)
      "}}}
    Plug 'editorconfig/editorconfig-vim'
  "}}}

  "{{{ Navigation, searching
    Plug 'ctrlpvim/ctrlp.vim' "{{{
     if s:ag
       let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
       " ag is fast enough that CtrlP doesn't need to cache
       let g:ctrlp_use_caching = 0
     else
       " Fall back to using git ls-files if Ag is not available
       let g:ctrlp_custom_ignore = '\.git$\|\.DS_Store$'
       let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
     endif
     "}}}
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } "{{{
      let g:NERDTreeWinSize=31 " Slightly narrower than default
      map <C-E> :NERDTreeToggle<CR>
      map <C-\> :NERDTreeFind<CR>
      "}}}
    Plug 'rking/ag.vim' "{{{
      let g:ag_working_path_mode="r"
      "}}}
  "}}}

  "{{{ Misc
    Plug 'junegunn/goyo.vim' "{{{
      let g:goyo_width=120 " Slightly wider than default (80)
      nnoremap <Leader>g :Goyo<CR>
      "}}}
    Plug 'vim-airline/vim-airline' "{{{
      let g:airline_powerline_fonts=1               " Nice fonts for airline
      let g:airline_detect_modified=1               " Visualize modified files
      let g:airline#extensions#tabline#enabled = 1
      "}}}
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'
    Plug 'christoomey/vim-tmux-navigator'
  "}}}

  "{{{ Languages
    Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
    Plug 'groenewege/vim-less', { 'for': 'less' }
    Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
    Plug 'digitaltoad/vim-jade', { 'for': 'jade' }
    Plug 'fsharp/vim-fsharp', {
          \ 'for': 'fsharp',
          \ 'do':  'make fsautocomplete',
          \}
    Plug 'ElmCast/elm-vim', { 'for': 'elm' } "{{{
      augroup filetype_elm
        autocmd!
        autocmd BufWritePost *.elm :ElmFormat
        autocmd BufWritePost *.elm :ElmMakeMain
      augroup END
    "}}}
    "{{{ JavaScript
      Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
      Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] } "{{{
        let g:jsx_ext_required = 0
        "}}}
      Plug 'gavocanov/vim-js-indent', { 'for': ['javascript', 'javascript.jsx'] }
      Plug 'moll/vim-node', { 'for': ['javascript', 'javascript.jsx'] }
      Plug 'marijnh/tern_for_vim', { 'do': 'npm install' , 'for': ['javascript', 'javascript.jsx'] } "{{{
        augroup filetype_javascript
            autocmd!
            autocmd FileType javascript nnoremap gd :TernDef<CR>
            autocmd FileType javascript nnoremap gr :TernRefs<CR>
            autocmd FileType javascript nnoremap gt :TernType<CR>
            autocmd FileType javascript nnoremap gtr :TernRename<CR>
        augroup END
        "}}}
    "}}}
  "}}}

  "{{{ Autocompletion, make
    Plug 'Shougo/deoplete.nvim' " {{{
      let g:deoplete#enable_at_startup = 1
      let g:deoplete#enable_smart_case = 1
      let g:deoplete#enable_auto_select = 1
      inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"
      inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
      set completeopt+=noinsert
      " let g:deoplete#sources#syntax#min_keyword_length = 2
      " let g:deoplete#auto_complete_start_length
      "}}}
    Plug 'benekastah/neomake' "{{{
      autocmd! BufWritePost * Neomake
      let g:neomake_open_list = 2
      let g:neomake_list_height = 4
      "}}}
  "}}}

  "{{{ Color schemes
    Plug 'chriskempson/base16-vim'
    Plug 'chriskempson/vim-tomorrow-theme'
    Plug 'altercation/vim-colors-solarized'
    Plug 'dracula/vim'
    Plug 'trevordmiller/nova-vim'
  "}}}

  call plug#end()
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
autocmd FileType javascript.jsx setlocal omnifunc=javascriptcomplete#CompleteJS

if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor
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
" set viminfo+=n~/.vim/viminfo

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
set tabstop=2                   " 2 spaces for tabs
set shiftwidth=2                " 2 spaces for each (auto)indent
set softtabstop=2               " Make spaces feel like tabs
set expandtab                   " Spaces for tabs
set nowrap                      " Don't soft wrap long lines
set list                        " Show invisible characters
set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮  " ... but only show tabs and trailing whitespace
"}}}

"{{{ Look and feel
set scrolloff=3             " Keep at least 3 lines above/below caret
set sidescrolloff=3         " ... and 3 to the left/right
syntax on                   " Syntax highlighting yay
set foldenable              " Enable folds by default
set foldmethod=syntax       " Fold via syntax of files
set foldlevelstart=99       " Open all folds by default
set splitright              " Horizontal splits open to the right
set splitbelow              " Vertical splits open below
set cursorline
" set background=dark         " Look nice
" colorscheme nova
" colorscheme base16-ocean
highlight clear LineNr
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
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" if has('nvim') " Window navigations in terminal mode
"     tnoremap <C-h> <C-\><C-n><C-w>h
"     tnoremap <C-j> <C-\><C-n><C-w>j
"     tnoremap <C-k> <C-\><C-n><C-w>k
"     tnoremap <C-l> <C-\><C-n><C-w>l
"     tnoremap <ESC> <C-\><C-n>
" endif

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

" Move by visual lines
nnoremap j gj
nnoremap k gk

" Start and end with H and L
map H ^
map L $

" Move line(s) up/down with alt+j/k
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Copy and paste from system clipboard with y and p
vmap <Leader>y "+y
vmap <Leader>d "+d
vmap <Leader>p "+p
vmap <Leader>P "+P
nmap <Leader>p "+p
nmap <Leader>P "+P

" Make Y behave like other capitals
nnoremap Y y$

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Autoformat
map <F7> mzgg=G`z

" Searching, finding
nnoremap gr :Ag! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap <Leader>a :Ag!
nnoremap <Leader>b :CtrlPBuffer<CR>
"}}}

