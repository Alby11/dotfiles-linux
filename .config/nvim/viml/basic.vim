set nocompatible            " disable compatibility to old-time vi
set modifiable
set autochdir

" encoding
set fileformats=unix,dos
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

set number
set ruler
set showcmd
set showmatch               " show matching
set ignorecase              " case insensitive
set cursorline              " highlight current cursorline
set hlsearch                " highlight search
set incsearch               " incremental search

" tabs
set tabstop=2               " number of columns occupied by a tab
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=2            " width for autoindents
set noexpandtab             " do not converts tabs to white space

" indenting
set autoindent              " indent a new line the same amount as the line just typed
set smartindent

" matching brackets
set showmatch
set matchtime=3

set wildmenu                " Enable auto completion menu after pressing TAB.
set wildmode=longest,list   " get bash-like tab completions
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx " There are certain files that we would never want to edit with Vim.
set cc=80                   " set an 80 column border for good coding style
set mouse=a                 " middle-click paste with
set clipboard=unnamedplus   " using system clipboard if supported (vim --version and look for +clipboard or +xterm_clipboard)
set splitright              " always split to the right
set splitbelow              " always split below
set ttyfast                 " Speed up scrolling in Vim set history=1000
set swapfile              " disable creating swap file
set backup
set writebackup

" how-to see the non-visible while spaces
" set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:.
set list

filetype plugin indent on   " allow auto-indenting depending on file type

syntax on                   " enables syntax highlighting

" Set undo directory
set undofile

" Set spelling options and personal dictionary location
set spellsuggest=fast,20    " Don't show too much suggestion for spell check.
set spell spelllang=        " enable spell check (may need to download language package)
      \ en_us,
      \ it,
      \ fr
set autoread                " Set to auto read when a file is changed from the outside
if has('win32')
  execute 'set spellfile=' . expand(config_dir) . '/spell/mywords.utf-8.add'
endif

" Set shell
if has("win32")
  if has('gui_win32')
    set shell=cmd
    set shellcmdflag =/c
  else
    set shell=pwsh.exe
    set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
    set shellxquote="
    set shellpipe=\|
    set shellredir=\|\ Out-File\ -Encoding\ UTF8
  endif
endif

" settings for gvim
if has('gui_running')
  set guioptions-=T  " no toolbar
  set guioptions+=d  " darker theme
  set lines=60 columns=108 linespace=0
  if has('gui_win32')
    set guifont=CaskaydiaCove\ Nerd\ Font:h9,courier_new:h9
  else
    set guifont=DejaVu\ Sans\ Mono\ 8
  endif
endif

" set gvim python env
if has('win32') && !has('nvim')

  " set pythonthreehome=C:\Users\personal\scoop\apps\python\current
  " set pythonthreedll=C:\Users\personal\scoop\apps\python\current\python310.dll
endif

" source remaining config files
execute 'source ' . expand(config_dir) . '/viml/truecolor.vim'
execute 'source ' . expand(config_dir) . '/viml/mappings.vim'
execute 'source ' . expand(config_dir) . '/viml/autocommands.vim'
execute 'source ' . expand(config_dir) . '/viml/commands.vim'
execute 'source ' . expand(config_dir) . '/viml/plugins.vim'
execute 'source ' . expand(config_dir) . '/viml/themes.vim'