" encoding
set encoding=utf-8

" Neobundle {{{
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

function! s:LoadBundles()
  NeoBundleFetch  'Shougo/neobundle.vim'

  " 実行
  NeoBundleLazy   'thinca/vim-quickrun'

  " 非同期処理
  NeoBundle       'Shougo/vimproc.vim'

  " 移動
  NeoBundle       'yonchu/accelerated-smooth-scroll'
  NeoBundle       'Lokaltog/vim-easymotion'
  NeoBundle       'scrooloose/nerdtree'

  " 入力
  NeoBundle       'Shougo/neocomplete'
  NeoBundle       'Shougo/neosnippet'
  NeoBundle       'Shougo/neosnippet-snippets'
  NeoBundle       'kana/vim-smartinput'
  NeoBundle       'tpope/vim-surround'
  NeoBundle       'digitaltoad/vim-pug'
  NeoBundle       'Quramy/tsuquyomi'

  " 確認
  NeoBundle       'scrooloose/syntastic'

  " 表示系
  NeoBundle       'thinca/vim-splash'
  NeoBundle       'ntpeters/vim-better-whitespace'
  NeoBundle       'leafgarland/typescript-vim'
  NeoBundle       'Shougo/context_filetype.vim'
  NeoBundle       'osyo-manga/vim-precious'

  " Git
  NeoBundle       'rhysd/committia.vim'

endfunction

" Plugin Settings {{{

" 実行系 {{{
" vim-quickrun {{{
if neobundle#tap('vim-quickrun')
  call neobundle#config({
        \   'autoload' : {
        \     'commands' : 'QuickRun'
        \   }
        \ })

  function! neobundle#tapped.hooks.on_source(bundle)
    let g:quickrun_config = {
          \    '_': {
          \      'runner': 'vimproc'
          \    },
          \    'ruby.rspec': {
          \      'command': 'rspec',
          \      'exec': 'bundle exec %c %s'
          \    },
          \  }
    set splitright
  endfunction

  nnoremap <silent><Leader>r :QuickRun<CR>

  call neobundle#untap()
endif
" }}}
" }}}

" 移動系 {{{
" easymotion {{{
if neobundle#tap('vim-easymotion')
  call neobundle#config({
        \   'autoload': {
        \     'mappings': ['<Plug>(easymotion-s2>']
        \   }
        \ })

  nmap e <Plug>(easymotion-s2)
  let g:EasyMotion_space_jump_first = 1
  call neobundle#untap()
endif
" }}}

" nerdtree {{{
if neobundle#tap('nerdtree')

  nnoremap <silent><C-e> :NERDTreeToggle<CR>

  call neobundle#untap()
endif

" }}}
" }}}


" TODO cacheの処理追加
call s:LoadBundles()
call neobundle#end()
filetype plugin indent on  " Required

NeoBundleCheck

" }}}


" 入力系 {{{
" neocomplete {{{
if neobundle#tap('neocomplete')
  " 起動時に有効にする

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


  "call neocomplete#custom#source('include', 'disabled', 1)
  "call neocomplete#custom#source('tag', 'disabled_filetypes', {'ruby' : 1})
  " autocmd FileType ruby NeoCompleteLock

  call neobundle#untap()
endif
" }}}

" neosnippet {{{
if neobundle#tap('neosnippet')
  "http://d.hatena.ne.jp/adragoona/20130929/1380437722
  "http://qiita.com/muran001/items/4a8ffafb9c6564313893

  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
endif
" }}}
" }}}

" 確認系 {{{
" syntastic {{{
if neobundle#tap('syntastic')
  let g:syntastic_enable_signs = 0
  let g:syntastic_check_on_open = 0
  let g:syntastic_check_on_wq = 1

  let g:syntastic_javascript_checkers = ['jshint']
  let g:syntastic_mode_map = {
        \ 'mode': 'active',
        \ 'active_filetypes': ['javascript'],
        \ 'passive_filetypes': ['ruby', 'html']
        \}
  hi SyntasticWarning ctermbg=11
  hi SyntasticError ctermbg=160

  call neobundle#untap()
endif

" }}}
" }}}

" 表示系 {{{
" vimsplash {{{
if neobundle#tap('vim-splash')
  let g:splash#path = $HOME . '/dotfiles/splash.txt'
  autocmd BufReadPre * autocmd! plugin-splash VimEnter
  call neobundle#untap()
endif
" }}}
" }}}

" Git {{{
" committia.vim {{{
if neobundle#tap('committia.vim')

  call neobundle#untap()
endif
" }}}
" }}}

" }}}

" FileType  {{{
" Omni Completion
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" When Rspec
autocmd BufnewFile,Bufread *_spec.rb set filetype=ruby.rspec
"autocmd BufNewFile,BufRead *.vue set filetype=html
" }}}

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

" vimdiffの色設定
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21
au BufRead,BufNewFile,BufReadPre *.jade set filetype=pug
au BufNewFile,BufRead *.json.jbuilder set ft=ruby
" }}}
