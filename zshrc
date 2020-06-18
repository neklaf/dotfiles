
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="~/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="gentoo"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# GOLANG VARIABLES AND PATH UPDATE
export GOPATH=$HOME/go-workspace
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

source ~/.bashrc

# GROOVY VARIABLES AND PATH UPDATE
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export SHELL=/usr/local/bin/bash

# MacPorts Installer addition on 2018-06-06_at_09:18:41: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$HOME/.local/bin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
export M2_HOME=/Applications/apache-maven-3.5.3
export PATH=$PATH:$M2_HOME/bin:${JAVA_HOME}/bin
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

alias filetree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"

#aliases
alias ll='ls -l'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#URGENT="2757"
URGENT="❗"
#DUETOMORROW="2690"
DUETOMORROW="🔆"
#DUETODAY="2691"
DUETODAY="😱"
#OVERDUE="2639"
OVERDUE="🐲"
TICK="✓"
CROSS="✗"
OK="2714"

# shows if any TaskWarrior tasks are in need of attention
function task_indicator {
    if [ `task +READY +OVERDUE count` -gt "0" ]  ; then
        printf "%b" "$OVERDUE"
    elif [ `task +READY +DUETODAY count` -gt "0" ]  ; then
        printf "%b" "$DUETODAY"
    elif [ `task +READY +DUETomorrow count` -gt "0" ]  ; then
        printf "%b" "$DUETOMORROW"
    elif [ `task +READY urgency \> 10 count` -gt "0" ]  ; then
        printf "%b" "$URGENT"
    else
        printf "%b" "$TICK"
    fi
}

alias tasks='task_indicator'
task="\$(task_indicator)"
addprompt=$task
export PROMPT="$addprompt $PROMPT"

# Function created to 50% of the time period
# First parameter is a tag to group the are
# Second parameter is the task name
# Example:
# $ task_add '+hype' 'install Prometheus in Hype'
function task_add {
   task add pro:adi $1 due:`date +%Y-%m-%d` $2 +next |
   while IFS= read -r line
   do
     if [[ $line == *"Created task"* ]]; then
        text='Created task '
        #echo "TASK CREATED WITH NUMBER ${line:${#text}:$((${#line}))}\n"
        num="${line:${#text}:${#line}}"
        task start ${num%?}
     fi
   done
}
alias taskadd='task_add'
