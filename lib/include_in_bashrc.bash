# This should be included into the user's .bashrc file)

export EDITOR="vim"

export SHELL_SESSION_HISTORY=0

# ./PWD_BIN comes before $SKIGGETY_UTILS_DIR/bin so that you can override scripts like "dashboard"
export PATH="$PATH:./PWD_BIN:$SKIGGETY_UTILS_DIR/bin:$HOME/bin"

export PS1="\$(duh)\$(git branch 2>/dev/null|grep '^*'|sed 's/^\\*/ \\*/') - \D{%F %T}\n\$ " # TODO: add colors (besides duh)

export CLICOLOR='xterm-color' # colorize ls output and such in mac xterm

# TODO: use more stuff from older bashrc files I've used

trap 'if [ "login" == "$(ps -o comm= $PPID)" ];then echo holding the window open for a short interval;pretty_sleep 15;fi' EXIT

# rbenv stuff (should be at the bottom of this file):
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# pyenv stuff (should be at the bottom of this file):
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    if pyenv init --help | grep path >/dev/null; then
        eval "$(pyenv init --path)"
    fi
    eval "$(pyenv init -)"
fi
