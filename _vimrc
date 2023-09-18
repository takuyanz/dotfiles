" encoding
set encoding=utf-8

if &compatible
  set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

"call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/context_filetype.vim')
call dein#add('yonchu/accelerated-smooth-scroll')
call dein#add('tpope/vim-surround')
call dein#add('Lokaltog/vim-easymotion')
call dein#add('kana/vim-smartinput')
call dein#add('ntpeters/vim-better-whitespace')
call dein#add('leafgarland/typescript-vim')
call dein#add('jparise/vim-graphql')
call dein#add('Shougo/ddc.vim')
call dein#add('vim-denops/denops.vim')

if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

" Install your UIs
call dein#add('Shougo/ddc-ui-native')

" Install your sources
call dein#add('Shougo/ddc-source-around')

" Install your filters
call dein#add('Shougo/ddc-matcher_head')
call dein#add('Shougo/ddc-sorter_rank')

call dein#end()

if dein#check_install()
  call dein#install()
endif

" ========================================
" deoplete設定
" ========================================

call ddc#custom#patch_global('ui', 'native')

" Use around source.
" https://github.com/Shougo/ddc-source-around
call ddc#custom#patch_global('sources', ['around'])

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', #{
      \ _: #{
      \   matchers: ['matcher_head'],
      \   sorters: ['sorter_rank']},
      \ })

" Mappings

" <TAB>: completion.
inoremap <silent><expr> <TAB>
\ pumvisible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

" Use ddc.
call ddc#enable()

"let g:deoplete#enable_at_startup = 1
"call deoplete#custom#option("max_list", 5)
"call deoplete#custom#option("min_pattern_length", 2)

""大文字が入力されるまで大文字小文字の区別を無視する
"let g:neocomplete#enable_smart_case = 1
"" _(アンダースコア)区切りの補完を有効化
"let g:neocomplete#enable_underbar_completion = 1
"let g:neocomplete#enable_camel_case_completion =  1
""ポップアップメニューで表示される候補の数
"let g:neocomplete#max_list = 5
""シンタックスをキャッシュするときの最小文字長
"let g:neocomplete#sources#syntax#min_keyword_length = 3
""補完を表示する最小文字数
"let g:neocomplete#auto_completion_start_length = 2
""preview window を閉じない
"let g:neocomplete#enable_auto_close_preview = 0
"let g:neocomplete#max_keyword_width = 50
"
"highlight Pmenu ctermbg=248
"highlight PmenuSel ctermbg=31
"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y> neocomplete#close_popup()
"inoremap <expr><C-e> neocomplete#cancel_popup()

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
colorscheme default
" }}}
