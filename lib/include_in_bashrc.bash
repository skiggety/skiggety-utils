# This should be included into the user's .bashrc file)

# WARNING: Changes to this file will make ./demo_in_docker very slow to start on the next run.  Hesitate to commit!

export BASH_SILENCE_DEPRECATION_WARNING=1
export SHELL_SESSION_HISTORY=0

# default value used only if EDITOR not otherwise set:
EDITOR=${EDITOR:-'vim'}
export EDITOR

# ./PWD_BIN comes before $SKIGGETY_UTILS_DIR/bin so that you can override scripts like "dashboard"
export PATH="$PATH:./PWD_BIN:$SKIGGETY_UTILS_DIR/bin:$HOME/bin"

# this weird way of getting the git branch works even when not in a git repo:
# TODO: extract the part that shows the git branch?:
export PS1="\$(duh)\$(git branch 2>/dev/null|grep '^*'|sed 's/^\\*/ \\*/') - \D{%F %T}\n\$ " # TODO: add colors (besides duh)

export CLICOLOR='xterm-color' # colorize ls output and such in mac xterm

if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files'
    export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

alias tmux="TERM=screen-256color-bce tmux"

alias be="bundle exec"
alias vw="vimwhich"
alias vf="vimfirst"

alias gir="git" # common enough typo for me
alias gac="git-attempt-checkout"
alias gd="git diff"
alias gds="git diff --staged"
alias gvd="git vimdiff"
alias gvds="git vimdiff --staged"
alias gvc="git vimchanged"
alias gvcs="git vimchanged --staged"
alias gpnb='git push-new-branch'
alias gp='git pretty-pull'
alias gat='git add-theirs'

alias cdsu="cd $SKIGGETY_UTILS_DIR"

# TODO: use more stuff from older bashrc files I've used

# TODO^2: TEST on linux:
# This is nice if you suddenly realize you need to copy some information off the screen, or if you want to keep a
# window/tab open with the same visual settings
trap 'if [ "login" == "$(ps -o comm= $PPID)" ];then echo holding this window open for a short interval just in case you exited prematurely;sleep-verbose 60;fi' EXIT

# asdf stuff (should be at the bottom of this file):
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"
if asdf current | grep '^direnv' >/dev/null; then
    . "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/bashrc"
fi
