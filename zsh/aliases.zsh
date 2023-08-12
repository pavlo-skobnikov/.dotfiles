#!/bin/sh

# Zsh-specific
alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

# Configurations
alias config='cd ~/.config/ && nvim ~/.config/'

# Fuzzy Searching
alias cda='cd $(find ~/ -type d -print | fzf)'                                                            # Search all directories for user
alias cdh='cd $(find . -type d -print | fzf)'                                                             # Search all directories from terminal's position
alias work='cd $(find ~/code/work -type d -path "*/.git" -print -prune | sed "s/\.git$//" | fzf)'         # Search work projects
alias personal='cd $(find ~/code/personal -type d -path "*/.git" -print -prune | sed "s/\.git$//" | fzf)' # Search personal projects
alias learn='cd $(find ~/code/learn -type d -path "*/.git" -print -prune | sed "s/\.git$//" | fzf)'       # Search personal projects

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
alias vim='nvim'                           # Use NeoVim as default editor
alias tvim="nvim '+lua vim.cmd(\"term\")'" # Open NeoVim's terminal in current directory
