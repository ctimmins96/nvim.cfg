echo "Loading aliases..."

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

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# QoL Aliases
alias refenv='source ~/.bashrc'
alias vim='~/nvim_src/build/bin/nvim'

# Editting Aliases
alias e_alac="vim $ALACRITTY_HOME/alacritty.yml"
alias e_bash="vim ~/.bashrc"
alias e_alias="vim ~/.bash_aliases"
alias e_vsvim="vim /mnt/c/Users/timmicx/.vimrc"
alias e_pspro="vim '$PSPROFILE/Microsoft.PowerShell_profile.ps1'"
alias e_zelj="vim ~/.config/zellij/config.kdl"
alias e_tmux="vim ~/.tmux.conf"
alias e_tmap="vim ~/.tmux/tmux.remaps.conf"

# Script Shortcuts
alias hex2binf="python3 ~/.scripts/hex2bin.py"
alias a2h="~/.scripts/ansi2html.sh"
alias git2html="git diff --color-words --no-index | a2h >"
alias makeproj="~/.scripts/makeproj"
alias makesig="~/.scripts/make_sig.sh"
alias submodinit="~/.scripts/submodinit"

# Aliases necessary because I am stupid and don't remember bash
alias howmanylines="find . -name "*.cs" -not -path '*/Debug/*' | xargs wc -l"

