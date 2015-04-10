let mapleader      = " "
let maplocalleader = " "

set nobackup
set nowritebackup
set noswapfile
set hidden
set incsearch
set autowrite
set clipboard=unnamed
set notimeout
set mouse=a
set undodir=/tmp//,.

set splitright
set splitbelow

syntax on

if filereadable(expand("~/.nvimrc.bundles"))
  source ~/.nvimrc.bundles
endif

set t_Co=256               " 256 colors

colorscheme pencil
set background=light

set noerrorbells           " Keep your mouth shut
set visualbell
set number                 " Always show line numbers
set colorcolumn=+1         " Make it obvious where 80 characters is

set hlsearch               " Highlight all matching searches
set ignorecase

set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set si                     " smart indent
set linebreak
set formatoptions+=n       " support for numbered/bullet lists
set virtualedit=block      " allow virtual edit in visual block ..
set nofoldenable           " dont fold by default

set list listchars=tab:»·,trail:·

set nolazyredraw           " turn off lazy redraw
set wildmode=list:longest,full

set diffopt+=vertical      " Always use vertical diffs

" GUI Settings
if has("gui_running")
  set anti
  set lines=999 columns=150
  set guioptions=egmrt
endif

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

" goto anything
nmap <leader><leader> :FZF -m<cr>

" (c)lose buffer
nmap <leader>c <Plug>Kwbd

" <esc> unhighlight search
nnoremap <esc> :noh<return><esc>

"(v)im (r)eload
nmap <silent> <leader>vr :so $MYVIMRC<cr>

" Semicolon at end of line by typing ;;
inoremap ;; <C-o>A;<esc>

" w!! to write a file as sudo
" stolen from Steve Losh
cmap w!! w !sudo tee % >/dev/null

" Remove trailing whitespace and ^M
nnoremap <leader>sn :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" buffer switching
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

" <leader>enter search for buffer
nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':      reverse(<sid>buflist()),
\   'sink':        function('<sid>bufopen'),
\   'options':     '+m',
\   'tmux_height': '20%'
\ })<CR>

" project search
function! s:agopen(e)
  let keys = split(a:e, ':')
  execute 'e +' . keys[1] . ' ' . escape(keys[0], ' ')
endfunction

" <leader>/ search for file contents
nnoremap <silent> <Leader>/ :call fzf#run({
\   'source':     'grep --line-buffered --color=never -r -n "" *',
\   'sink':       function('<sid>agopen'),
\   'options':    '-e -m',
\   'tmux_height': '20%'
\ })<CR>

" ---------------------------------------------------------------------------
"  Plugin settings
" ---------------------------------------------------------------------------

" Syntastic Config
let g:syntastic_check_on_open=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

" NeoComplete & NeoSnippets
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1

" <tab> completion
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" expand snippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" snippet complete marker
if has('conceal')
  set conceallevel=2 concealcursor=i
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

" 4 spaces for php
autocmd FileType php setlocal ts=4 sts=4 sw=4

" github-flavored markdown
autocmd BufNewFile,BufReadPost *.md setlocal filetype=ghmarkdown
