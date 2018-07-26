" encoding
set encoding=utf-8

if &compatible
  set nocompatible
endif

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/context_filetype.vim')
call dein#add('yonchu/accelerated-smooth-scroll')
call dein#add('tpope/vim-surround')
call dein#add('Lokaltog/vim-easymotion')
call dein#add('kana/vim-smartinput')
call dein#add('ntpeters/vim-better-whitespace')

call dein#end()

if dein#check_install()
  call dein#install()
endif

" ========================================
" neocomplete設定
" ========================================

let g:neocomplete#enable_at_startup = 1
"大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplete#enable_smart_case = 1
" _(アンダースコア)区切りの補完を有効化
let g:neocomplete#enable_underbar_completion = 1
let g:neocomplete#enable_camel_case_completion =  1
"ポップアップメニューで表示される候補の数
let g:neocomplete#max_list = 5
"シンタックスをキャッシュするときの最小文字長
let g:neocomplete#sources#syntax#min_keyword_length = 3
"補完を表示する最小文字数
let g:neocomplete#auto_completion_start_length = 2
"preview window を閉じない
let g:neocomplete#enable_auto_close_preview = 0
let g:neocomplete#max_keyword_width = 50

highlight Pmenu ctermbg=248
highlight PmenuSel ctermbg=31

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()

" ========================================
" neosinippet設定
" ========================================
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" Key Mappings {{{
cmap w!! w !sudo tee > /dev/null %

noremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <silent> <C-h> :<C-u>tabprevious<CR>

inoremap <C-j> <ESC>
nnoremap <S-l> $
nnoremap <S-h> ^

nnoremap q: :q
nnoremap <Space>w :w<CR>
nnoremap <Space>q :q<CR>

" Tab Split {{{
nnoremap ss :split<Space>
nnoremap sv :vsplit<Space>
" 移動 {{{
nnoremap  sh <C-w>h
nnoremap  sj <C-w>j
nnoremap  sk <C-w>k
nnoremap  sl <C-w>l
nnoremap  sw <C-w>w
" }}}
" ウィンドウの移動 {{{
nnoremap  sH <C-w>H
nnoremap  sJ <C-w>J
nnoremap  sK <C-w>K
nnoremap  sL <C-w>L
nnoremap  sr <C-w>r
" }}}
" 大きさ変更 {{{
nnoremap  s= <C-w>=
" }}}
" 閉じる {{{
nnoremap :bd sQ
" }}}
" }}}

" disable cursor keys
nnoremap <Right> <Nop>
nnoremap <Left>  <Nop>
nnoremap <Up>    <Nop>
nnoremap <Down>  <Nop>
vnoremap <Right> <Nop>
vnoremap <Left>  <Nop>
vnoremap <Up>    <Nop>
vnoremap <Down>  <Nop>
inoremap <Right> <Nop>
inoremap <Left>  <Nop>
inoremap <Up>    <Nop>
inoremap <Down>  <Nop>
" }}}

" Other {{{
syntax on
set encoding=utf-8
set number
set tabstop=2
set ambiwidth=double
set number
set title
set tabstop=2
set shiftwidth=2
set autoindent
set expandtab
set smartindent
set backspace=indent,eol,start
set showmatch
set matchtime=3
set incsearch
set hlsearch
set ignorecase
set smartcase
set viminfo-=h
set autoread
set noswapfile
set visualbell t_vb=
set noerrorbells
set wrap
set foldmethod=marker
set display=lastline
set cursorline
set backupskip=/tmp/*,/private/tmp/*

" 現在の行番号をハイライト表示する
hi clear CursorLine
hi CursorLineNr term=bold   cterm=NONE ctermfg=228 ctermbg=NONE

au BufRead,BufNewFile,BufReadPre *.jade set filetype=pug
au BufNewFile,BufRead *.json.jbuilder set ft=ruby
filetype plugin indent on
" }}}
