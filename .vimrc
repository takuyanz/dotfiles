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
  NeoBundleLazy   'Lokaltog/vim-easymotion'

  " 入力
  NeoBundle       'Shougo/neocomplete'
  NeoBundle       'kana/vim-smartinput'

  " 確認
  "NeoBundle      'wookiehangover/jshint.vim'

  " 表示系
  NeoBundle       'thinca/vim-splash'
  NeoBundle       'ntpeters/vim-better-whitespace'

  " Git
  NeoBundle       'rhysd/committia.vim'

endfunction

" TODO cacheの処理追加
call s:LoadBundles()
call neobundle#end()
filetype plugin indent on  " Required

NeoBundleCheck

" }}}

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

" 入力系 {{{
" neocomplete {{{
if neobundle#tap('neocomplete')
  " 起動時に有効にする
  let g:neocomplete#enable_at_startup = 1
  " 大文字と小文字が混在した場合に区別する
  let g:neocomplete#enable_smart_case = 1
  " ポップアップ内に表示される候補の数
  let g:neocomplete#max_list = 10
  " 補完を行う最小文字数
  let g:neocomplete#auto_completion_start_length = 2

  highlight Pmenu ctermbg=248
  highlight PmenuSel ctermbg=31

  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()

  " Enable heavy omni completion.
  "if !exists('g:neocomplete#force_omni_input_patterns')
    "let g:neocomplete#force_omni_input_patterns = {}
  "endif
  "let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

  call neobundle#untap()
endif
" }}}
" }}}

" 表示系 {{{
" vimsplash {{{
if neobundle#tap('vim-splash')
  let g:splash#path = $HOME . '/randomFiles/splash.txt'
  autocmd BufReadPre * autocmd! plugin-splash VimEnter
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
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" When Rspec
autocmd BufnewFile,Bufread *_spec.rb set filetype=ruby.rspec
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
" }}}
