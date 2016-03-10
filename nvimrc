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

" <tab> cycle through windows
nnoremap <tab> <c-w>w

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

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Neomake
autocmd! BufWritePost,BufEnter * Neomake
let g:neomake_open_list = 2
let g:neomake_javascript_jscs_maker = {
    \ 'exe': 'jscs',
    \ 'args': ['--no-color', '--preset', 'airbnb', '--reporter', 'inline', '--esnext'],
    \ 'errorformat': '%f: line %l\, col %c\, %m',
    \ }
let g:neomake_javascript_enabled_makers = ['jscs']

" expand matchpairs on return
let delimitMate_expand_cr = 1

" react in .js
let g:jsx_ext_required = 0

" 4 spaces for php
autocmd FileType php setlocal ts=4 sts=4 sw=4

" github-flavored markdown
autocmd BufNewFile,BufReadPost *.md setlocal filetype=ghmarkdown

" Neovim Terminal colors schema
"
" This is Tomorrow Night 80s
" https://github.com/chriskempson/tomorrow-theme
let g:terminal_color_0 = "#000000"
let g:terminal_color_1 = "#f78d8c"
let g:terminal_color_2 = "#a8d4a9"
let g:terminal_color_3 = "#a8d4a9"
let g:terminal_color_4 = "#ffd479"
let g:terminal_color_5 = "#78aad6"
let g:terminal_color_6 = "#d7acd6"
let g:terminal_color_7 = "#76d4d6"
let g:terminal_color_8 = "#ffffff"
let g:terminal_color_9 = "#000000"
let g:terminal_color_10 = "#f78d8c"
let g:terminal_color_11 = "#a8d4a9"
let g:terminal_color_12 = "#ffd479"
let g:terminal_color_13 = "#78aad6"
let g:terminal_color_14 = "#d7acd6"
let g:terminal_color_15 = "#76d4d6"
let g:terminal_color_16 = "#ffffff"
let g:terminal_color_background="#2d2d2d"
let g:terminal_color_foreground="#cccccc"
