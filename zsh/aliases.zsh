#!/bin/sh

# Zsh-specific
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# Configurations
alias config='cd ~/.config/ && nvim ~/.config/'

# Fuzzy Searching
alias cda='cd $(find ~/ -type d -print | fzf)'                       # Search all directories for user
alias cdh='cd $(find . -type d -print | fzf)'                        # Search all directories from terminal's position
alias projects='cd $(find ~/dev/projects -maxdepth 1 -type d | fzf)' # Search projects

# Colorize GREP Output (Good For Log Files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Confirm Before Overwriting Something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# Easier to Read Disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# Chrome CLI Shortcut
alias chrome="open -a 'Google Chrome'"

# NeoVim
alias vim='nvim'                                                   # Use NeoVim as default editor
