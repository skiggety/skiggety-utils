#!/usr/bin/env bash

# This script is merely a way to control where and how and how often to run demo_python_version_hack &
# demo_ruby_version_hack to do whatever testing I need to do. And control where the output goes, etc.

. $SKIGGETY_UTILS_DIR/lib/skiggety-utils.bash || exit 1

# TODO: It might be interesting to try running this in different docker containers

# go where there's no accurate .python-version to rely on to put these version hacks to the test:
cd ~/today_todo/

for cmd in demo_python_version_hack \
           demo_ruby_version_hack
do
    OUTFILE=$SKIGGETY_UTILS_DIR/logs/$cmd.log.$(whoami).at.$(hostname).XXX.txt
    mkdir -p "$(dirname "$OUTFILE")"
    touch "$OUTFILE"
    echo "from: $(git config user.email)" | tee $OUTFILE
    echo "at: $(duh)" | tee -a $OUTFILE
    echo_divider "="
    echo "pyenv version returns:" | tee -a $OUTFILE
    pyenv version | tee -a $OUTFILE
    debug_eval_here PYTHON_VERSION_HACK_DEPTH 2>&1 | tee -a $OUTFILE
    # shellask "congrats, you are in a debugger at $(echo_here)"
    echo "running: '$cmd'" | tee -a $OUTFILE
    $cmd >> $OUTFILE 2>&1 || accumulate_error "$cmd FAILED"
    echo "your test results are in $OUTFILE"
    echo "last line is:"
    tail -n 1 "$OUTFILE"

    exit_with_error "stopping now: one language at a time TODO: DELETE when the python hack is working everywhere"
    exit_if_any_accumulated_errors
done

# TODO^2: DELETE this script when done
