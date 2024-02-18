# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Exports
export PATH="/home/chase/.local/share/bob/nvim-bin:/home/chase/.modular/pkg/packages.modular.com_mojo/bin:$PATH"
export MODULAR_HOME="/home/chase/.modular"
export ALACRITTY_HOME="/mnt/c/Users/Chase/AppData/Roaming/alacritty"
export SNIPPETS='~/.config/nvim/LuaSnip'
export ZELLIJ_HOME="~/.config/zellij"
export GITLAB_HOME="/mnt/e/gitlab"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# Aliases


# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias refenv='source ~/.bashrc'
alias vim='nvim'
alias e_alac="vim $ALACRITTY_HOME/alacritty.yml"
alias e_bash="vim ~/.bashrc"
alias e_zelj="vim ~/.config/zellij/config.kdl"
alias e_tmux="vim ~/.tmux.conf"
alias e_tmap="vim ~/.tmux/tmux.remaps.conf"
alias cargotest="RUST_BACKTRACE=FULL cargo test"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
. "$HOME/.cargo/env"

eval ``keychain --eval --agents ssh id_rsa
[ -f "/home/chase/.ghcup/env" ] && source "/home/chase/.ghcup/env" # ghcup-env

## Terminal Customization
#
# Setup
# - Date / Time
# - Path
# - Git information

source ~/.git-prompt.sh

peng=""
lmda="󰘧"
sect=""
arr1="󰝲"
arr2="󱞩"

FMT_BOLD="\[\e[1m\]"
FMT_DIM="\[\e[2m\]"
FMT_RESET="\[\e[0m\]"
FMT_UNBOLD="\[\e[22m\]"
FMT_UNDIM="\[\e[22m\]"
FG_BLACK="\[\e[30m\]"
FG_BLUE="\[\e[34m\]"
FG_CYAN="\[\e[36m\]"
FG_GREEN="\[\e[32m\]"
FG_YELLOW="\[\e[33m\]"
FG_GREY="\[\e[37m\]"
FG_MAGENTA="\[\e[35m\]"
FG_RED="\[\e[31m\]"
FG_WHITE="\[\e[97m\]"
BG_BLACK="\[\e[40m\]"
BG_BLUE="\[\e[44m\]"
BG_CYAN="\[\e[46m\]"
BG_GREEN="\[\e[42m\]"
BG_YELLOW="\[\e[43m\]"
BG_MAGENTA="\[\e[45m\]"

#PS1="${BG_BLUE}${FG_GREEN}${FMT_BOLD} ${peng} \d ${FG_WHITE}\t ${FG_BLUE}"
#PS1+='$(__git_ps1 "' # check if git branch exists
#PS1+="${BG_MAGENTA}${sect} " # end FILES container / begin BRANCH container
#PS1+="${FG_WHITE}${brch} %s ${FG_MAGENTA}" # print current git branch
#PS1+='")'
#PS1+="${BG_GREEN}${sect}${FG_BLUE} \w ${FMT_RESET}${FMT_BOLD}${FG_GREEN}${sect} "
#PS1+="${FG_GREEN}${lmda}"
#PS1+="${FMT_RESET}"
PS1="${BG_BLUE}${FG_GREEN}${FMT_BOLD} ${peng} \d ${FG_WHITE}\t ${FG_BLUE}\$(__git_ps1 \"${BG_MAGENTA}${sect}${FG_WHITE}  %s ${FG_MAGENTA}\")${BG_GREEN}${sect}${FG_BLUE} \w ${FMT_RESET}${FMT_BOLD}${FG_GREEN}${sect} ${lmda} ${FMT_RESET}"
export PS1

