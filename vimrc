set nocompatible

let mapleader = ","

set ttyfast
set backspace=2
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler
set showcmd
set incsearch
set laststatus=2
set autowrite
if exists('+undodir')
  set undodir=~/.backups
endif
if exists('+undofile')
  set undofile
endif

set clipboard=unnamed
set notimeout
set mouse=a
set ttymouse=xterm2
set magic
set hidden

set splitright
set splitbelow

syntax on

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" ----------------------------------------------------------------------------
"  Colors
" ----------------------------------------------------------------------------
colorscheme pencil
set background=light

if has("gui_running")
  set anti
  set lines=999 columns=150
  set guifont=Ubuntu\ Mono\ for\ Powerline:h18,Monaco:h17
  set guioptions=egmrt

  if has('win32') || has('win64')
    set guifont=Ubuntu\ Mono\ for\ Powerline:h12,Consolas:h12
  endif

  " Show tab number (useful for Cmd-1, Cmd-2.. mapping)
  autocmd VimEnter * set guitablabel=%N:\ %t\ %M
endif

" ----------------------------------------------------------------------------
"  Visual Settings
" ----------------------------------------------------------------------------

set noerrorbells
set novisualbell
set number

set hlsearch
set ignorecase

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set si                     " smart indent
set linebreak
set formatoptions+=n       " support for numbered/bullet lists
set virtualedit=block      " allow virtual edit in visual block ..
set nofoldenable           " dont fold by default

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" ----------------------------------------------------------------------------
"  UI
" ----------------------------------------------------------------------------

set nolazyredraw           " turn off lazy redraw
set wildmode=list:longest,full
set wildignore+=*/.hg/*,*/.svn/*,*/vendor/cache/*,*/public/system/*,*/tmp/*,*/log/*,*/.git/*,*/.jhw-cache/*,*/solr/data/*,*/node_modules/*,*/.DS_Store

" ----------------------------------------------------------------------------
"  Remapping
" ----------------------------------------------------------------------------

" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" sane window movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" sane window creation
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" Toggle NERDTree
map <C-d> :NERDTreeToggle<CR>

" project search
nmap <leader>f :Ag<space>

" goto buffer
nmap <C-b> :CtrlPBuffer<cr>
imap <C-b> <esc>:CtrlPBuffer<cr>

" goto symbol
nmap <C-r> :CtrlPBufTag<cr>
imap <C-r> <esc>:CtrlPBufTag<cr>
nmap <C-R> :CtrlPBufTagAll<cr>
imap <C-R> <esc>:CtrlPBufTagAll<cr>

" goto file
nmap <C-t> :CtrlP<cr>
imap <C-t> <esc>:CtrlP<cr>

" toggle tagbar
nmap <leader>] :TagbarToggle<cr>

" (c)lose buffer
nmap <C-c> <Plug>Kwbd

" Fixing search
nnoremap / /\v
vnoremap / /\v
nmap <silent> // :nohlsearch<cr>

"(v)im (r)eload
nmap <silent> <leader>vr :so %<cr>

" Semicolon at end of line by typing ;;
inoremap ;; <C-o>A;<esc>

" w!! to write a file as sudo
" stolen from Steve Losh
cmap w!! w !sudo tee % >/dev/null

" Remove trailing whitespace and ^M
nnoremap <leader>sn :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" ---------------------------------------------------------------------------
"  Plugin settings
" ---------------------------------------------------------------------------

" Airline
let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme = 'pencil'

" Make nerdtree look nice
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
let g:NERDSpaceDelims=1

" Don't auto open nerd tree on startup
let g:nerdtree_tabs_open_on_gui_startup = 0
" Focus in the main content window
let g:nerdtree_tabs_focus_on_files = 1

" Syntastic Config
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

" NeoComplete & NeoSnippets
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1

" Recommended key-mappings.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ? "\<C-n>" : "\<TAB>")
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
smap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
	let g:ackprg = 'ag --nogroup --column'
	" Use Ag over Grep
	set grepprg=ag\ --nogroup\ --nocolor
	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" expand matchpairs on return
let delimitMate_expand_cr = 1

" Fix Cursor in TMUX
if exists('$TMUX')
	let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
	let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
	let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" ---------------------------------------------------------------------------
"  Auto cmd stuff for file types
" ---------------------------------------------------------------------------

if has("autocmd")
  autocmd FileType mkd,txt setlocal wrap linebreak nolist
  autocmd FileType php setlocal ts=4 sts=4 sw=4
endif

au BufNewFile,BufRead *.twig set ft=jinja

augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

