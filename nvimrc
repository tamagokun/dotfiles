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

let g:one_allow_italics = 1 " use italics with `one` theme
set background=dark
set termguicolors
colorscheme night-owl

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
set inccommand=nosplit     " show substitutions live

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

" <leader>enter search for buffer
nnoremap <silent> <Leader><Enter> :Buffer<cr>

" <leader>/ search for file contents
nnoremap <silent> <Leader>/ :Rg<cr>

" :Rg to search in project
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
\   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
\           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
\   <bang>0)

" ---------------------------------------------------------------------------
"  Plugin settings
" ---------------------------------------------------------------------------

let g:deoplete#enable_at_startup = 1 " enable deoplete
let g:deoplete#sources = {'_': ['ale']}

let g:ale_linters = {
  \ 'javascript': ['eslint', 'flow'],
  \ 'jsx': ['eslint', 'flow']
  \ }

let g:ale_fixers = {
  \ 'javascript': ['prettier', 'eslint'],
  \ 'jsx': ['prettier', 'eslint']
  \ }

let g:ale_fix_on_save = 1

" expand matchpairs on return
let delimitMate_expand_cr = 1

" react in .js
let g:jsx_ext_required = 0
let g:javascript_plugin_flow = 1

" support closetags in jsx
let g:closetag_filenames = '*.html,*.js'
let g:closetag_xhtml_filenames = '*.html,*.js'

" 4 spaces for php
autocmd FileType php setlocal ts=4 sts=4 sw=4

" github-flavored markdown
autocmd BufNewFile,BufReadPost *.md setlocal filetype=ghmarkdown

" ---------------------------------------------------------------------------
"  Status line
" ---------------------------------------------------------------------------

let g:currentmode={
    \ 'n'  : 'N ',
    \ 'no' : 'N·Operator Pending ',
    \ 'v'  : 'V ',
    \ 'V'  : 'V·Line ',
    \ '^V' : 'V·Block ',
    \ 's'  : 'Select ',
    \ 'S'  : 'S·Line ',
    \ '^S' : 'S·Block ',
    \ 'i'  : 'I ',
    \ 'R'  : 'R ',
    \ 'Rv' : 'V·Replace ',
    \ 'c'  : 'Command ',
    \ 'cv' : 'Vim Ex ',
    \ 'ce' : 'Ex ',
    \ 'r'  : 'Prompt ',
    \ 'rm' : 'More ',
    \ 'r?' : 'Confirm ',
    \ '!'  : 'Shell ',
    \ 't'  : 'Terminal '
    \}

function! ReadOnly()
  if &readonly || !&modifiable
    return ''
  else
    return ''
endfunction

set statusline=
set statusline +=%1*\ %*%2*\ %*%3*\ %* " pattern (in)
set statusline +=%4*\ %{g:currentmode[mode()]}%*    " current mode
set statusline +=%5*\ %n\ %*           " buffer number
set statusline +=%3*\ %*               " separator
set statusline +=%6*\ %<%F\ %{ReadOnly()}\ %m\ %w\ %*         " file
set statusline +=%3*\ %*               " separator
set statusline +=%=                    " right-side
set statusline +=%3*\ %*               " separator
set statusline +=%4*\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]\ %* " file encoding
set statusline +=%3*\ %*%0*\ %*        " separator
set statusline +=%4*\ %y\ %*           " file-type
set statusline +=%3*\ %*%0*\ %*        " separator
set statusline +=%5*\ %3p%%\ \ %l:\ %3c\ %*           " buffer number
set statusline +=%3*\ %*%2*\ %*%1*\ %* " pattern (out)

hi StatusLine guibg=#3a3a3a
hi User1 guibg=#5faf87
hi User2 guibg=#3a3a3a
hi User3 guibg=#303030
hi User4 guibg=#262626 guifg=#dfdf5f
hi User5 guibg=#444444 guifg=#ffaf5f
hi User6 guibg=#262626 guifg=#87af5f
