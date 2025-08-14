" ========================================
" Encoding settings (must be at the top)
" ========================================
set encoding=utf-8
scriptencoding utf-8

if &compatible
  set nocompatible
endif

" ========================================
" Plugin Manager Setup (Dein.vim)
" ========================================
let s:dein_base = expand('~/.cache/dein')
let s:dein_src = s:dein_base . '/repos/github.com/Shougo/dein.vim'
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Auto-install dein.vim if not present
if !isdirectory(s:dein_src)
  call system('git clone https://github.com/Shougo/dein.vim ' . s:dein_src)
endif

call dein#begin(s:dein_base)

" Core plugins
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

" ========================================
" Denops & ddc.vim (modern autocomplete)
" ========================================
" IMPORTANT: Requires Deno to be installed
" Install from: https://deno.land/
call dein#add('vim-denops/denops.vim')
call dein#add('Shougo/ddc.vim')

" ddc UI plugins - multiple options for better experience
call dein#add('Shougo/ddc-ui-native')  " Native UI
call dein#add('Shougo/ddc-ui-pum')     " Popup menu UI (recommended)
call dein#add('Shougo/pum.vim')        " Required for ddc-ui-pum

" ddc sources - various completion sources
call dein#add('Shougo/ddc-source-around')    " Words from current buffer
call dein#add('LumaKernel/ddc-source-file')  " File path completion
call dein#add('Shougo/ddc-source-cmdline')   " Command line completion
call dein#add('Shougo/ddc-source-input')     " Input history
call dein#add('Shougo/ddc-source-omni')      " Omni completion
call dein#add('matsui54/ddc-buffer')         " Better buffer word completion

" ddc filters - for matching and sorting
call dein#add('Shougo/ddc-filter-matcher_head')     " Head matching
call dein#add('Shougo/ddc-filter-matcher_length')   " Length-based matching
call dein#add('Shougo/ddc-filter-sorter_rank')      " Smart ranking
call dein#add('Shougo/ddc-filter-converter_remove_overlap')  " Remove duplicates

" Snippet support
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')

" ========================================
" Language support & utilities
" ========================================
call dein#add('Shougo/context_filetype.vim')
call dein#add('leafgarland/typescript-vim')
call dein#add('jparise/vim-graphql')
call dein#add('pangloss/vim-javascript')
call dein#add('maxmellon/vim-jsx-pretty')

" ========================================
" Editor enhancements
" ========================================
call dein#add('yonchu/accelerated-smooth-scroll')
call dein#add('tpope/vim-surround')
call dein#add('easymotion/vim-easymotion')  " Updated repository
call dein#add('kana/vim-smartinput')
call dein#add('ntpeters/vim-better-whitespace')
call dein#add('tpope/vim-commentary')  " Easy commenting
call dein#add('jiangmiao/auto-pairs')  " Auto-close brackets

" Compatibility layers for older Vim
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

call dein#end()

" Auto-install missing plugins on startup
if dein#check_install()
  call dein#install()
endif

" ========================================
" ddc.vim Configuration (Modern Autocomplete)
" ========================================

" Check if Deno is installed before trying to use ddc
let s:deno_available = executable('deno')

if s:deno_available
  " Only configure ddc if Deno is available
  
  " Silently check denops status without displaying messages
  silent! call denops#server#status()

" Set the UI - using pum for best experience
try
  call ddc#custom#patch_global('ui', 'pum')
catch
  " Fallback to native if pum is not available
  try
    call ddc#custom#patch_global('ui', 'native')
  catch
  endtry
endtry

" Configure multiple completion sources
try
  call ddc#custom#patch_global('sources', [
        \ 'around',
        \ 'buffer',
        \ 'file',
        \ ])
catch
endtry

" Global source options
try
  call ddc#custom#patch_global('sourceOptions', #{
      \ _: #{
      \   ignoreCase: v:true,
      \   matchers: ['matcher_head'],
      \   sorters: ['sorter_rank'],
      \   converters: ['converter_remove_overlap'],
      \   minAutoCompleteLength: 2,
      \   timeout: 500,
      \ },
      \ around: #{
      \   mark: '[A]',
      \   matchers: ['matcher_head'],
      \ },
      \ buffer: #{
      \   mark: '[B]',
      \ },
      \ file: #{
      \   mark: '[F]',
      \   isVolatile: v:true,
      \   minAutoCompleteLength: 2,
      \   forceCompletionPattern: '\.\w*|:\w*|/\w*',
      \ },
      \ })
catch
endtry

" Source-specific parameters
try
  call ddc#custom#patch_global('sourceParams', #{
      \ around: #{
      \   maxSize: 500,
      \ },
      \ buffer: #{
      \   requireSameFiletype: v:false,
      \   limitBytes: 5000000,
      \   fromAltBuf: v:true,
      \   forceCollect: v:true,
      \ },
      \ })
catch
endtry

" Configure pum.vim (popup menu)
try
  call pum#set_option(#{
        \ auto_select: v:false,
        \ border: 'single',
        \ max_height: 20,
        \ min_height: 3,
        \ padding: v:false,
        \ preview: v:true,
        \ scrollbar_char: '│',
        \ })
catch
  " Ignore if pum is not available
endtry

  " ========================================
  " Key Mappings for ddc.vim
  " ========================================
  
  " TAB: Smart completion and navigation
  inoremap <silent><expr> <TAB>
        \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
        \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
        \ '<TAB>' : ddc#map#manual_complete()
  
  " Shift-TAB: Navigate backwards in completion menu
  inoremap <expr><S-TAB> pum#visible() ? '<Cmd>call pum#map#insert_relative(-1)<CR>' : '<C-h>'
  
  " Enter: Confirm completion
  inoremap <silent><expr> <CR>
        \ pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'
  
  " Ctrl-E: Cancel completion
  inoremap <expr><C-e> pum#visible() ? '<Cmd>call pum#map#cancel()<CR>' : '<End>'
  
  " Ctrl-Y: Confirm completion (alternative)
  inoremap <expr><C-y> pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<C-y>'
  
  " Ctrl-Space: Force trigger completion
  inoremap <expr><C-Space> ddc#map#manual_complete()

" Enable ddc.vim only if denops is available
try
  if exists('*denops#server#status') && s:deno_available
    call ddc#enable()
    " Performance settings - increase delay to reduce server load
    call ddc#custom#patch_global('autoCompleteDelay', 150)
    call ddc#custom#patch_global('backspaceCompletion', v:true)
  endif
catch
  " Silently ignore if ddc is not available
endtry

else
  " Fallback key mappings when Deno/ddc is not available
  " Simple TAB completion using built-in completion
  inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
  inoremap <expr> <C-e> pumvisible() ? "\<C-e>" : "\<End>"
endif " End of Deno/ddc configuration

" ========================================
" Neosnippet Configuration
" ========================================
" Plugin key-mappings
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" For conceal markers
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Enable snipMate compatibility feature
let g:neosnippet#enable_snipmate_compatibility = 1

" ========================================
" Key Mappings
" ========================================
" Sudo write (for files opened without sudo)
cmap w!! w !sudo tee > /dev/null %

" Clear search highlighting with double Escape
noremap <silent> <Esc><Esc> :nohlsearch<CR>

" Tab navigation
nnoremap <silent> <C-h> :<C-u>tabprevious<CR>
nnoremap <silent> <C-l> :<C-u>tabnext<CR>

" Quick escape from insert mode
inoremap <C-j> <ESC>
inoremap jj <ESC>

" Quick line navigation
nnoremap <S-l> $
nnoremap <S-h> ^

" Prevent accidental command history
nnoremap q: :q

" Quick save and quit
nnoremap <Space>w :w<CR>
nnoremap <Space>q :q<CR>
nnoremap <Space>x :x<CR>

" ========================================
" Window Management
" ========================================
" Split windows
nnoremap ss :split<Space>
nnoremap sv :vsplit<Space>
nnoremap st :tabnew<Space>

" Navigate between windows
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sw <C-w>w

" Move windows
nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sr <C-w>r

" Resize windows
nnoremap s= <C-w>=
nnoremap s> <C-w>>
nnoremap s< <C-w><
nnoremap s+ <C-w>+
nnoremap s- <C-w>-

" Close windows
nnoremap sq :q<CR>
nnoremap sQ :bd<CR>

" ========================================
" Disable Arrow Keys (Force Vim Navigation)
" ========================================
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

" ========================================
" General Vim Settings
" ========================================
" Enable syntax highlighting
syntax enable
filetype plugin indent on

" Display settings
set number              " Show line numbers
set norelativenumber    " Disable relative numbers to fix scrolling issues
set signcolumn=yes      " Always show sign column to prevent shifting
set title               " Show file title in terminal
set nocursorline        " Disable cursorline to prevent display issues
set showmatch           " Show matching brackets
set matchtime=3         " Bracket match time
set wrap                " Wrap long lines
set display=lastline    " Show as much as possible of the last line
set ambiwidth=double    " Handle double-width characters

" Indentation settings
set tabstop=2           " Tab width
set shiftwidth=2        " Indent width
set softtabstop=2       " Soft tab width
set expandtab           " Use spaces instead of tabs
set autoindent          " Auto indent
set smartindent         " Smart indent

" Search settings
set incsearch           " Incremental search
set hlsearch            " Highlight search results
set ignorecase          " Case insensitive search
set smartcase           " Smart case search

" Editor behavior
set backspace=indent,eol,start  " Better backspace behavior
set autoread            " Auto-reload changed files
set noswapfile          " Disable swap files
set nobackup            " Disable backup files
set undofile            " Enable persistent undo
set undodir=~/.vim/undo " Undo directory
set viminfo-=h          " Don't highlight on startup
set hidden              " Allow hidden buffers
set mouse=a             " Enable mouse support
set clipboard=unnamed   " Use system clipboard

" Performance settings
set lazyredraw          " Don't redraw during macros
set ttyfast             " Fast terminal connection
set updatetime=300      " Faster completion
set timeoutlen=500      " Faster key sequence completion

" Disable bells
set visualbell t_vb=
set noerrorbells

" Folding
set foldmethod=marker   " Use markers for folding
set foldlevel=99        " Open all folds by default

" File-specific settings
set backupskip=/tmp/*,/private/tmp/*

" ========================================
" UI Customization
" ========================================
" Highlight line numbers
hi LineNr ctermfg=240
hi CursorLineNr term=bold cterm=bold ctermfg=228

" Popup menu colors
hi Pmenu ctermbg=235 ctermfg=250
hi PmenuSel ctermbg=31 ctermfg=255
hi PmenuSbar ctermbg=236
hi PmenuThumb ctermbg=239

" ========================================
" Filetype Settings
" ========================================
augroup FileTypeSettings
  autocmd!
  " Jade/Pug files
  autocmd BufRead,BufNewFile,BufReadPre *.jade set filetype=pug
  " JSON Builder files
  autocmd BufNewFile,BufRead *.json.jbuilder set ft=ruby
  " TypeScript/JavaScript
  autocmd BufNewFile,BufRead *.ts,*.tsx set filetype=typescript
  autocmd BufNewFile,BufRead *.js,*.jsx set filetype=javascript
  " GraphQL
  autocmd BufNewFile,BufRead *.graphql,*.gql set filetype=graphql
augroup END

" Color scheme
colorscheme default

" ========================================
" Status Line
" ========================================
set laststatus=2        " Always show status line
set statusline=%F       " Full file path
set statusline+=%m      " Modified flag
set statusline+=%r      " Read only flag
set statusline+=%h      " Help buffer flag
set statusline+=%=      " Right align
set statusline+=%y      " File type
set statusline+=[%{&fileencoding}]  " File encoding
set statusline+=[%l/%L] " Current line / Total lines
set statusline+=[%p%%]  " Percentage through file
set statusline+=[%c]    " Column number