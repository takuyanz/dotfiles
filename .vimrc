set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

" 実行系
NeoBundle 'thinca/vim-quickrun'

" 移動系
NeoBundle 'yonchu/accelerated-smooth-scroll'
NeoBundle 'Lokaltog/vim-easymotion'

" 入力系
NeoBundle "Shougo/neocomplete.vim"
NeoBundle "kana/vim-smartinput"

" 確認系
"NeoBundle 'scrooloose/syntastic'
"NeoBundle "wookiehangover/jshint.vim"

" 表示系
NeoBundle 'thinca/vim-splash'
if neobundle#tap('vim-splash')
  let g:splash#path = $HOME . '/randomFiles/splash.txt'
  " Don't work starting 'vim -t {tag}'
  autocmd BufReadPre * autocmd! plugin-splash VimEnter
  call neobundle#untap()
endif
NeoBundle 'ntpeters/vim-better-whitespace'

call neobundle#end()

" Required:
filetype plugin indent on

" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck

"-------------------------
" End Neobundle Settings.
"-------------------------

" NeoComplete Setting

let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#max_list = 10
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'


" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" Rubocop setting
let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

" JSHint Setting
let g:JSHintHighlightErrorLine = 0

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

" /--- key mapping ---/

nnoremap <silent> <C-h> :<C-u>tabprevious<CR>
inoremap <C-j> <ESC>
" save as super user
cmap w!! w !sudo tee > /dev/null %
" Esc to remove highlightes
nmap <silent> <Esc><Esc> :nohlsearch<CR>
" disabling cursor keys
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

" /--- plugin key mapping ---/

" Easy Motion
map <Leader> <Plug>(easymotion-prefix)
nmap s <Plug>(easymotion-s2)

" NeoComplete
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()"
