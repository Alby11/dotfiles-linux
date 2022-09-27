if command -v dotfiles &>/dev/null
then
  dotfiles remote update && \
  dotfiles status -uno  ; \
  ;
  if $?
  then
    echo "Local is up to date"
  else
    echo "Local is behind"
  fi
fi
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# set up environment, depending on os
if grep -qi microsoft /proc/version ; then
  echo "ubuntu on wsl"
  [ ! -d ~/.wp ] && ln -s $(wslpath "$(wslvar userprofile)") ~/.wp
  export PROFILEFILES=$(wslpath "$(wslvar onedriveconsumer)/profilefiles")
  ln -sf $PROFILEFILES ~/
  export PROFILEFILES=~/profilefiles
  # tmux
  # win32yank_exe="/mnt/c/programdata/scoop/apps/neovim-nightly/current/bin/win32yank.exe"
  win32yank_exe=$(wslpath "$(wslvar programdata)")/scoop/shims/win32yank.exe
  if [ -e $win32yank_exe ] && [ ! -f /usr/local/bin/win32yank.exe ] ; then
    sudo ln -s $win32yank_exe "/usr/local/bin/win32yank.exe"
  fi
elif grep -qi ubuntu /proc/version ; then
  echo "native ubuntu linux"
  if [ -d ~/profilefiles ];
  then
    cd ~/profilefiles
    git pull
    cd ~
  else
    cd ~
    git clone git@github.com:alby11/profilefiles.git
  fi
  export PROFILEFILES=~/profilefiles
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  colored-man-pages
  colorize
  command-not-found
  copybuffer
  copyfile
  copypath
  docker
  docker-compose
  fd
  fzf
  git
  kubectl
  kubectx
  minikube
  npm
  pep8
  pip
  pyenv
  python
  ripgrep
  ssh-agent
  sudo
  ubuntu
  vi-mode
  virtualenv
  virtualenvwrapper
  vscode
  web-search
  zoxide
)

VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true
MODE_INDICATOR="%F{white}+%f"
INSERT_MODE_INDICATOR="%F{yellow}+%f"

source $ZSH/oh-my-zsh.sh


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

[ -f ~/.bash_exports ] && source ~/.bash_exports

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Catppuccin TTT theme
source /home/alby11/catppuccin_tty/mocha.sh

### Initialize Starship
if test -f $PROFILEFILES/starship/starship.toml; then  
  export STARSHIP_CONFIG=$PROFILEFILES/starship/starship.toml
  eval "$(starship init zsh)"
fi
