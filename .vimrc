"  1 important {{{

call plug#begin('~/.vim/bundle')
Plug 'tpope/vim-sensible'
Plug 'shougo/vimproc', {'do': 'make'}
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'thinca/vim-unite-history'
Plug 'Shougo/neomru.vim'
if has('lua') && (version >= 704 || version == 703 && has('patch885'))
  Plug 'Shougo/neocomplete.vim'
  let g:completionEngine = 'neocomplete'
else
  Plug 'Shougo/neocomplcache.vim'
  let g:completionEngine = 'neocomplcache'
endif
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-dispatch'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'scrooloose/syntastic'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tomtom/tcomment_vim'
Plug 'vim-scripts/camelcasemotion'
Plug 'itchyny/lightline.vim'
Plug 'Raimondi/delimitMate'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/ShowMarks'
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/IndexedSearch'
Plug 'vim-scripts/copypath.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'sjl/gundo.vim', {'on': 'GundoToggle'}
Plug 'gregsexton/gitv', {'on': 'Gitv'}
Plug 'morhetz/gruvbox'
Plug 'bogado/file-line'
Plug 'sheerun/vim-polyglot'
Plug 'rizzatti/dash.vim'
call plug#end()

" }}}
"  2 moving around, searching and patterns {{{

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

" }}}
"  3 tags {{{
" }}}
"  4 displaying text {{{

set number

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" }}}
"  5 syntax, highlighting and spelling {{{
" }}}
"  6 multiple windows {{{

" allow buffer switching without saving
set hidden

" }}}
"  7 multiple tab pages {{{
"  }}}
"  8 terminal {{{
"  }}}
"  9 using the mouse {{{
"  }}}
" 10 GUI {{{

set background=dark
let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set t_Co=256
  set guitablabel=%M\ %t
  set guifont=Inconsolata:h18
endif

" }}}
" 11 printing {{{
" }}}
" 12 messages and info {{{

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" }}}
" 13 selecting text {{{
" }}}
" 14 editing text {{{
" }}}
" 15 tabs and indenting {{{

" Use spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab
" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2
" Linebreak on 500 characters
set linebreak
set textwidth=500
set autoindent
set smartindent
set nowrap "Wrap lines

" }}}
" 16 folding {{{
" }}}
" 17 diff mode {{{
" }}}
" 18 mapping {{{

let mapleader = ","
let g:mapleader = ","

" make Y behave like C and D
nnoremap Y y$

" Make 0 go to the first character rather than the beginning
" of the line. When we're programming, we're almost always
" interested in working with text rather than empty space. If
" you want the traditional beginning of line, use ^
nnoremap 0 ^
nnoremap ^ 0

" center after going to next word
nnoremap n nzz
nnoremap N Nzz

" maintain selection after indenting
xnoremap < <gv
xnoremap > >gv

nnoremap <silent><leader>cp :CopyPath<CR>

" upper case camel case motion
map W <Plug>CamelCaseMotion_w
map B <Plug>CamelCaseMotion_b
map E <Plug>CamelCaseMotion_e
sunmap W
sunmap B
sunmap E

nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>

nnoremap <silent> <leader>cl :lclose<CR>
nnoremap <silent> <leader>ol :lopen<CR>

nnoremap <silent> <Left> :bprevious<CR>
inoremap <silent> <Left> :bprevious<CR>

nnoremap <silent> <Right> :bnext<CR>
inoremap <silent> <Right> :bnext<CR>

" }}}
" 19 reading and writing files {{{
" }}}
" 20 the swap file {{{

if exists("&directory")
  " ensure swaps directory exists
  if !isdirectory("~/.vim/swaps")
    call system("mkdir ~/.vim/swaps")
  endif
  set directory=~/.vim/swaps/
endif

" }}}
" 21 command line editing {{{

if version >= 703
  if exists("&undodir")
    " ensure undo directory exists
    if !isdirectory("~/.vim/undo")
      call system("mkdir ~/.vim/undo")
    endif
    set undodir=~/.vim/undo/
  endif
  set undofile
  set undoreload=10000
endif
set undolevels=10000
if exists("&backupdir")
  " ensure backup directory exists
  if !isdirectory("~/.vim/backups")
    call system("mkdir ~/.vim/backups")
  endif
  set backupdir=~/.vim/backups/
endif

" }}}
" 22 executing external commands {{{

" }}}
" 23 running make and jumping to errors {{{
" }}}
" 24 language specific {{{

" }}}
" 25 multi-byte characters {{{
" }}}
" 26 various {{{

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

"}}}
" whitespace killer {{{
" via: http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()
nmap ,w :StripTrailingWhitespaces<CR>

" }}}
" showmarks {{{
" Tell showmarks to not include the various brace marks (),{}, etc
let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXY"
" }}}
" nerdtree {{{
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
" Auto open nerd tree on startup
let g:nerdtree_tabs_open_on_gui_startup = 0
" Focus in the main content window
let g:nerdtree_tabs_focus_on_files = 1
nnoremap <D-N> :NERDTreeTabsToggle<CR>
" }}}
" indentLine {{{
let g:indentLine_char = '¦'
nnoremap <Leader>ig :IndentLinesToggle<CR>
" }}}
" lightline: "{{{
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [
      \     ['mode', 'paste'],
      \     ['fugitive', 'readonly', 'filename']
      \   ],
      \   'right': [
      \     ['lineinfo', 'syntastic'],
      \     ['percent'],
      \     ['fileformat', 'fileencoding', 'filetype']
      \   ]
      \ },
      \ 'component_function': {
      \   'fileencoding' : 'MyFileencoding',
      \   'fileformat'   : 'MyFileformat',
      \   'filename'     : 'MyFilename',
      \   'filetype'     : 'MyFiletype',
      \   'mode'         : 'MyMode',
      \   'modified'     : 'MyModified',
      \   'readonly'     : 'MyReadonly',
      \   'syntastic'    : 'SyntasticStatuslineFlag',
      \   'fugitive'     : 'MyFugitive'
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
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

function! MyFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction
"}}}
" syntastic {{{
"mark syntax errors with :signs
let g:syntastic_enable_signs=1
"automatically jump to the error when saving the file
let g:syntastic_auto_jump=0
"show the error list automatically
let g:syntastic_auto_loc_list=0
" show multiple checkers at once
let g:syntastic_aggregate_errors = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_javascript_checkers = ['jshint', 'jscs']

" }}}
" neocomplete {{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_camel_case = 1
let g:neocomplete#enable_smart_case = 1

" Default # of completions is 100, that's crazy.
let g:neocomplete#max_list = 5

" Set minimum syntax keyword length.
let g:neocomplete#auto_completion_start_length = 3

" Map standard Ctrl-N completion to Cmd-Space
inoremap <C-Space> <C-n>

" This makes sure we use neocomplete completefunc instead of
" the one in rails.vim, otherwise this plugin will crap out.
let g:neocomplete#force_overwrite_completefunc = 1

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
" }}}
" neosnippet {{{
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
"}}}
" unite {{{
let g:unite_split_rule = "botright"
let g:unite_force_overwrite_statusline = 0
let g:unite_source_history_yank_enable = 1
let g:unite_winheight = 10

" use fuzzy matcher in unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ '\.bundler/',
      \ '\.cache/',
      \ '\.vendor/',
      \ ], '\|'))

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

function! s:unite_settings()
  nmap <buffer> Q <plug>(unite_exit)
  nmap <buffer> <esc> <plug>(unite_exit)
  imap <buffer> <esc> <plug>(unite_exit)
endfunction
autocmd FileType unite call s:unite_settings()

nnoremap <Leader>t :Unite -start-insert -buffer-name=files buffer file_rec/async<CR>
nnoremap <Leader>b :Unite -start-insert -buffer-name=buffers buffer<CR>
nnoremap <Leader>T :Unite -start-insert -buffer-name=outline outline<CR>
nnoremap <Leader>g :Unite -no-quit -buffer-name=search grep:.<CR>
nnoremap <Leader>y :Unite -buffer-name=yanks history/yank<CR>
nnoremap <Leader>h :Unite -buffer-name=commands history/command<CR>
nnoremap <Leader>r :Unite -start-insert -buffer-name=recent file_mru<CR>

function! GetVisual()
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save
  return selection
endfunction

"grep the current word using K (mnemonic Kurrent)
nnoremap <silent> K :<C-U>execute "Unite -no-quit -buffer-name=search grep:.::" . expand('<cword>')<CR>

"grep visual selection with K
vnoremap <silent> K :<C-U>execute "Unite -no-quit -buffer-name=search grep:.::" . escape(GetVisual(), ' ')<CR>
" }}}
" ranger {{{

" Compatible with ranger 1.4.2 through 1.6.*
"
" Add ranger as a file chooser in vim
"
" If you add this code to the .vimrc, ranger can be started using the command
" ":RangerChooser" or the keybinding "<leader>r".  Once you select one or more
" files, press enter and ranger will quit again and vim will open the selected
" files.

function! RangeChooser()
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    "exec 'silent !ranger --choosefile=' . shellescape(temp)
    exec 'silent !ranger --choosefiles=' . shellescape(temp)
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()
nnoremap <silent> <leader>rc :<C-U>RangerChooser<CR>

" }}}
