#!/usr/bin/env bash

# This script is merely a way to control where and how and how often to run demo_python_version_hack &
# demo_ruby_version_hack to do whatever testing I need to do. And control where the output goes, etc.

. $SKIGGETY_UTILS_DIR/lib/skiggety-utils.bash || exit 1
SKIGGETY_DEBUG=true

# TODO^31: call this from your local PWD/experiment.gitignored.bash on all machines that want to
# participate in debugging.

# go where there's no accurate .python-version to rely on to put these version hacks to the test:
cd ~/today_todo/

for cmd in demo_python_version_hack \
           demo_ruby_version_hack
do
    # TODO: try ask_user congrats, you are in a debugger at TODO_current_script_name_and_line_number_TODO
    OUTFILE=$SKIGGETY_UTILS_DIR/logs/$cmd.log.$(whoami).at.$(hostname).txt
    mkdir -p "$(dirname "$OUTFILE")"
    touch "$OUTFILE"
    echo "from: $(git config user.email)" | tee $OUTFILE
    echo "at: $(duh)" | tee -a $OUTFILE
    echo "running: '$cmd'" | tee -a $OUTFILE
    $cmd | tee -a $OUTFILE || accumulate_error "$cmd FAILED"
    echo "your test results are in $OUTFILE"

    exit_with_error "stopping now: one language at a time TODO: DELETE when the python hack is working everywhere"
    exit_if_any_accumulated_errors
done

# TODO: DELETE this script when done
