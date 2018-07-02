# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dpoggi"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias lo="exit"
alias ls="ls --color=auto"
alias ll="ls -lA | more"
alias lsd="ls -lA | grep ^d"
alias vi="vim"

# Connect to work systems
alias test1="ssh bshayne@test1.hltcoe.jhu.edu"
alias test2="ssh bshayne@test2.hltcoe.jhu.edu"
alias test3="ssh bshayne@test3.hltcoe.jhu.edu"
alias test4="ssh bshayne@test4.hltcoe.jhu.edu"
alias gpsrv5="ssh bshayne@gpsrv5.hltcoe.jhu.edu"

function sync-to(){
        for i in "$@"; do
                scp -rp ~/.zshrc ~/.screenrc ~/.tmux.conf ~/.emacs.d ~/.ssh/config ${i}:
        done
}

function sync-from(){
        scp -rp ${1}:.zshrc ${1}:.screenrc ${1}:.tmux.conf ${1}:.emacs.d ${1}:.ssh/config ~
}

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
HIST_STAMPS="mm/dd/yyyy"

# keep history file between sessions
HISTSIZE=1000
SAVEHIST=1000

#for sharing history between zsh processes
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

#"running" `/etc` actually does a `cd /etc`
setopt AUTO_CD
#correct mistakes
setopt CORRECT
setopt AUTO_LIST 
#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD
#tab completion moves to end of word
setopt ALWAYS_TO_END
setopt listtypes 

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(colored-man-pages colorize git iwhois nmap tmux ubuntu wd web-search zsh_reload)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/opt/coreutils/libexec/gnubin:/snap/bin:$PATH"
export MANPATH="/usr/local/man:/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# # Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='mvim'
fi

# enable color support of ls
if [ "$TERM" != "dumb" ]; then
    [ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
    [ -e "$DIR_COLORS" ] || DIR_COLORS=""
    eval "`dircolors -b $DIR_COLORS`"
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

