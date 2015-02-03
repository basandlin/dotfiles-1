" ==================================================
" plugins
" ==================================================
call plug#begin('~/.vim/bundle')
Plug 'tpope/vim-sensible'
Plug 'shougo/vimproc', {'do': 'make'}
Plug 'Shougo/unite.vim'
if has('lua') && (version >= 704 || version == 703 && has('patch885'))
	Plug 'Shougo/neocomplete.vim'
	let g:completionEngine = 'neocomplete'
else
	Plug 'Shougo/neocomplcache.vim'
	let g:completionEngine = 'neocomplcache'
endif
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/vimfiler', {'on': 'VimFiler'}
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'scrooloose/syntastic'
Plug 'tomtom/tcomment_vim'
Plug 'vim-scripts/camelcasemotion'
Plug 'itchyny/lightline.vim'
Plug 'vim-scripts/IndexedSearch'
Plug 'nelstrom/vim-visual-star-search'
Plug 'sjl/gundo.vim', {'on': 'GundoToggle'}
Plug 'Raimondi/delimitMate'
Plug 'altercation/vim-colors-solarized'
Plug 'bogado/file-line'
Plug 'sheerun/vim-polyglot'
call plug#end()

set background=dark
colorscheme solarized

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

" Set extra options when running in GUI mode
if has("gui_running")
	set guioptions-=T
	set guioptions-=e
	set t_Co=256
	set guitablabel=%M\ %t
	set guifont=Inconsolata:h22
endif

if version >= 703
    if exists("&undodir")
        set undodir=~/.vim/undo//
    endif
    set undofile
    set undoreload=10000
endif
set undolevels=10000
if exists("&backupdir")
    set backupdir=~/.vim/backups//
endif
if exists("&directory")
    set directory=~/.vim/swaps//
endif

if executable('ag')
	set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
	set grepformat=%f:%l:%C:%m
	let g:unite_source_grep_command='ag'
	let g:unite_source_grep_default_opts='--nocolor --nogroup --hidden'
	let g:unite_source_grep_recursive_opt=''
	let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup --hidden -g ""'
elseif executable('ack')
	set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
	set grepformat=%f:%l:%c:%m
	let g:unite_source_grep_command='ack'
	let g:unite_source_grep_default_opts='--no-heading --no-color'
	let g:unite_source_grep_recursive_opt=''
endif

let mapleader = ","
let g:mapleader = ","

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

set number
"if exists('+rnu') | set relativenumber | endif

" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch

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

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab
" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2
" Linebreak on 500 characters
set lbr
set tw=500
set ai "Auto indent
set si "Smart indent
set nowrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" light line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline: "{{{
let g:lightline = {
        \ 'colorscheme': 'solarized',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [
        \     ['mode', 'paste'],
        \     ['filename']
        \   ],
        \   'right': [
        \     ['lineinfo', 'syntastic'],
        \     ['percent'],
        \     ['charcode', 'fileformat', 'fileencoding', 'filetype']
        \   ]
        \ },
        \ 'component_function': {
        \   'charcode'     : 'MyCharCode',
        \   'fileencoding' : 'MyFileencoding',
        \   'fileformat'   : 'MyFileformat',
        \   'filename'     : 'MyFilename',
        \   'filetype'     : 'MyFiletype',
        \   'mode'         : 'MyMode',
        \   'modified'     : 'MyModified',
        \   'readonly'     : 'MyReadonly',
        \   'syntastic'    : 'SyntasticStatuslineFlag',
        \ }
        \ }
 
function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
 
function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '⭤' : ''
endfunction
 
function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
 
function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction
 
function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction
 
function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction
 
function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction
 
function! MyCharCode()
  if winwidth('.') <= 70
    return ''
  endif
 
  " Get the output of :ascii
  redir => ascii
  silent! ascii
  redir END
 
  if match(ascii, 'NUL') != -1
    return 'NUL'
  endif
 
  " Zero pad hex values
  let nrformat = '0x%02x'
 
  let encoding = (&fenc == '' ? &enc : &fenc)
 
  if encoding == 'utf-8'
    " Zero pad with 4 zeroes in unicode files
    let nrformat = '0x%04x'
  endif
 
  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F>  70" => char: 'F', nr: '70'
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')
 
  " Format the numeric value
  let nr = printf(nrformat, nr)
 
  return "'". char ."' ". nr
endfunction
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" key mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" make Y behave like C and D
nnoremap Y y$

" center after going to next word
nnoremap n nzz
nnoremap N Nzz

" maintain selection after indenting
xnoremap < <gv
xnoremap > >gv

" upper case camel case motion
map W <Plug>CamelCaseMotion_w
map B <Plug>CamelCaseMotion_b
map E <Plug>CamelCaseMotion_e
