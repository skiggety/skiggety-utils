# This should be included into the user's .bashrc file)

# WARNING: Changes to this file will make ./demo_in_docker very slow to start on the next run. Hesitate to commit!

# TODO: somebody please set this to nano and then submit a pr to make other stuff work with nano, lol
export EDITOR="vim"

export SHELL_SESSION_HISTORY=0

# ./PWD_BIN comes before $SKIGGETY_UTILS_DIR/bin so that you can override scripts like "dashboard"
export PATH="$PATH:./PWD_BIN:$SKIGGETY_UTILS_DIR/bin:$HOME/bin"

# this weird way of getting the git branch works even when not in a git repo:
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

# TODO: use more stuff from older bashrc files I've used

# This is nice if you suddenly realize you need to copy some information off the screen, or if you want to keep a
# window/tab open with the same visual settings
trap 'if [ "login" == "$(ps -o comm= $PPID)" ];then echo holding this window open for a short interval just in case you exited prematurely;sleep-verbose 10;fi' EXIT

# rbenv stuff (should be at the bottom of this file):
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null;then
    eval "$(rbenv init -)"
fi

# pyenv stuff (should be at the bottom of this file):
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    if pyenv init --help | grep path >/dev/null; then
        eval "$(pyenv init --path)"
    fi
    eval "$(pyenv init -)"
fi
