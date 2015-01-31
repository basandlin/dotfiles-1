" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" detect OS {{{
let s:is_windows = has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_macvim = has('gui_macvim')
"}}}

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

let s:cache_dir = '~/.vim/.cache'

function! s:get_cache_dir(suffix) "{{{
 return resolve(expand(s:cache_dir . '/' . a:suffix))
endfunction "}}}

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'tpope/vim-fugitive'
NeoBundleLazy 'scrooloose/nerdtree', {'autoload':{'commands':['NERDTreeToggle','NERDTreeFind']}} "{{{
  let NERDTreeMinimalUI=1
  let NERDTreeShowHidden=1
  let NERDTreeQuitOnOpen=0
  let NERDTreeShowLineNumbers=1
  let NERDTreeChDirMode=0
  let NERDTreeShowBookmarks=0
  let NERDTreeIgnore=['\.git','\.hg']
  nnoremap <leader>n :NERDTreeToggle<CR>
  nnoremap <leader>f :NERDTreeFind<CR>
"}}}
NeoBundle 'tpope/vim-surround'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-rails'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'matchit.zip'
NeoBundle 'rking/ag.vim'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'tpope/vim-sensible'
NeoBundle 'Shougo/unite.vim' "{{{
  let bundle = neobundle#get('unite.vim')
  function! bundle.hooks.on_source(bundle)
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    call unite#custom#source('line,outline','matchers','matcher_fuzzy')
    call unite#custom#profile('default', 'context', {
          \ 'start_insert': 1,
          \ 'direction': 'botright',
          \ })
  endfunction
  let g:unite_data_directory=s:get_cache_dir('unite')
  let g:unite_source_history_yank_enable=1
  let g:unite_source_rec_max_cache_files=5000
  if executable('ag')
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts='--nocolor --line-numbers --nogroup -S -C4'
    let g:unite_source_grep_recursive_opt=''
  elseif executable('ack')
    let g:unite_source_grep_command='ack'
    let g:unite_source_grep_default_opts='--no-heading --no-color -C4'
    let g:unite_source_grep_recursive_opt=''
  endif
  function! s:unite_settings()
    nmap <buffer> Q <plug>(unite_exit)
    nmap <buffer> <esc> <plug>(unite_exit)
    imap <buffer> <esc> <plug>(unite_exit)
  endfunction
  autocmd FileType unite call s:unite_settings()
  nmap <space> [unite]
  nnoremap [unite] <nop>
  if s:is_windows
    nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec:! buffer file_mru bookmark<cr><c-u>
    nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec:!<cr><c-u>
  else
    nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec/async:! buffer file_mru bookmark<cr><c-u>
    nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async:!<cr><c-u>
  endif
  nnoremap <silent> [unite]e :<C-u>Unite -buffer-name=recent file_mru<cr>
  nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
  nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
  nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
  nnoremap <silent> [unite]/ :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
  nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
  nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>
  "}}}
  NeoBundleLazy 'Shougo/neomru.vim', {'autoload':{'unite_sources':'file_mru'}}
  NeoBundleLazy 'osyo-manga/unite-airline_themes', {'autoload':{'unite_sources':'airline_themes'}} "{{{
    nnoremap <silent> [unite]a :<C-u>Unite -winheight=10 -auto-preview -buffer-name=airline_themes airline_themes<cr>
  "}}}
  NeoBundleLazy 'ujihisa/unite-colorscheme', {'autoload':{'unite_sources':'colorscheme'}} "{{{
    nnoremap <silent> [unite]c :<C-u>Unite -winheight=10 -auto-preview -buffer-name=colorschemes colorscheme<cr>
  "}}}
  NeoBundleLazy 'tsukkee/unite-tag', {'autoload':{'unite_sources':['tag','tag/file']}} "{{{
    nnoremap <silent> [unite]t :<C-u>Unite -auto-resize -buffer-name=tag tag tag/file<cr>
  "}}}
  NeoBundleLazy 'Shougo/unite-outline', {'autoload':{'unite_sources':'outline'}} "{{{
    nnoremap <silent> [unite]o :<C-u>Unite -auto-resize -buffer-name=outline outline<cr>
  "}}}
  NeoBundleLazy 'Shougo/unite-help', {'autoload':{'unite_sources':'help'}} "{{{
    nnoremap <silent> [unite]h :<C-u>Unite -auto-resize -buffer-name=help help<cr>
  "}}}
  NeoBundleLazy 'Shougo/junkfile.vim', {'autoload':{'commands':'JunkfileOpen','unite_sources':['junkfile','junkfile/new']}} "{{{
    let g:junkfile#directory=s:get_cache_dir('junk')
    nnoremap <silent> [unite]j :<C-u>Unite -auto-resize -buffer-name=junk junkfile junkfile/new<cr>
"}}}

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=1000

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" ================ Completion =======================
set wildmode=list:longest
set wildmenu "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*.pyc,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildmenu

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" show line numbers
set number

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
try
	colorscheme solarized
catch
endtry

set background=dark
" Set extra options when running in GUI mode
if has("gui_running")
    set guifont=Inconsolata:h22
	set guioptions-=T
	set guioptions-=e
	set t_Co=256
	set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
    silent !mkdir ~/.vim/backups > /dev/null 2>&1
    set undodir=~/.vim/backups
    set undofile
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Linebreak on 500 characters
set linebreak
set textwidth=500

set autoindent
set smartindent
set nowrap "don't wrap lines

set list listchars=tab:\ \ ,trail:·

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "normal! g`\"" |
\ endif

" Remember info about open buffers on close
set viminfo^=%

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" ================ Custom Settings ========================
source ~/.vim/settings.vim
