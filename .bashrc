alias grep='grep --color=auto'

function grepr { grep -R "$*" . --color ; }
function pygrep { grep -R --include='*.py' "$*" . --color ; }
function pyigrep { grep -iR --include='*.py' "$*" . --color ; }
function scgrep { grep -R --include='*.scala' "$*" . --color ; }
function scigrep { grep -iR --include='*.scala' "$*" . --color ; }
function sbtonly { sbt "test-only * -- -z \"$*\"" ; }
# Continuous build & test
function sbtonlyalways { sbt "~test-only * -- -z \"$*\"" ; }

# custom prompt
export PS1='\[\e[0;32m\]\u\[\e[m\]@\[\e[36m\]desktop\[\e[m\] \[\e[1;34m\]\w\[\e[m\]\[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

# dim out compiled and backup files
export LS_COLORS="$LS_COLORS:*~=01;30:*.pyc=01;30"

TMUXSETTERM="TERM='screen-256color'"
alias tmux="$TMUXSETTERM tmux -2"
alias tls='tmux list-sessions'
alias tat='tmux attach-session -d -t'

alias tmuxconnect='tmux new-session -t'
alias tmuxclose='tmux kill-session -t'

alias l='ls -al'
alias sl='ls -al'

alias fixtmux='tmux detach-client -a -s'

# move to trash, replacement for rm
alias del='gvfs-trash'

# Add virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh

alias pypathhere="export PYTHONPATH=\`pwd\`"
alias gs="git status"

# git push to upstream
alias gp="git push --set-upstream origin \$(git branch | awk '/^\\* / { print \$2 }')"
