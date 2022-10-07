" Set data dir. If you are using nvim, it is OS independent
let g:data_dir = has("nvim") ? stdpath('data') . '/site' : has("win32") ? $HOME . '/vimfiles' : '~/.vim'
let plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

" Auto install Plug-Vim if missing
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo ' . data_dir . '/autoload/plug.vim --create-dirs '. plug_url
    if has('win32')
        silent execute 'qa!'
    else
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

" Set plugin dir
let plugin_dir = has("nvim") ? stdpath('data') : has("win32") ? $HOME . '/vimfiles' : '~/.vim'

call plug#begin(plugin_dir . '/plugged')

    " Run PlugInstall if there are missing plugins
    autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
        \| PlugInstall --sync | source $MYVIMRC
    \| endif

    " Tim Popej
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-commentary'

    " Svermuelen
    Plug 'svermeulen/vim-cutlass'
    Plug 'svermeulen/vim-yoink'
    Plug 'svermeulen/vim-subversive'

    " adds more targets to operate on (di, da etc.)
    Plug 'wellle/targets.vim'

    " Git stuff
    " Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
    Plug 'mhinz/vim-signify'
    Plug 'tpope/vim-fugitive'

    " Fuzzy seach, like fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " collection of language packs for Vim
    Plug 'sheerun/vim-polyglot'

    " Autocomplete with coc.nvim/vim
    if has('nvim')
        Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}
    else
        Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
    endif
    Plug 'yaegassy/coc-ansible', {'do': 'yarn install --frozen-lockfile'}

    " Snippets with vsnip
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'rafamadriz/friendly-snippets'
    
    " tagbar
    Plug 'preservim/tagbar'

    " Autoformat
    Plug 'vim-autoformat/vim-autoformat'
    " Powershell
    " Plug 'pprovost/vim-ps1'
    Plug 'jaydoubleu/vim-pwsh-formatter'

    " Easymotion
"    Plug 'easymotion/vim-easymotion' 
    " Sneak
    Plug 'justinmk/vim-sneak'
   
    " Nerdtree
    Plug 'preservim/nerdtree'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    "  Plug 'scrooloose/nerdtree-project-plugin'
    Plug 'PhilRunninger/nerdtree-buffer-ops'
    Plug 'PhilRunninger/nerdtree-visual-selection'
    Plug 'ryanoasis/vim-devicons'

    " Themes
    Plug 'dracula/vim'
    Plug 'folke/tokyonight.nvim'", { 'branch': 'main' }
    Plug 'joshdick/onedark.vim'
    Plug 'tomasiser/vim-code-dark'

    " Vim-airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

call plug#end()

" source plugins configuration files
for i in (readdir(expand(config_dir) . '/viml/plugins'))
    execute 'source ' . expand(config_dir) . '/viml/plugins/' . expand(i)
endfor
