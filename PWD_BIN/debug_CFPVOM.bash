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
    OUTFILE=$cmd.gitignored.output.txt
    echo "at: $(duh)" | tee $OUTFILE
    echo "running: '$cmd'" | tee $OUTFILE
    $cmd | tee -a $OUTFILE || exit_with_error "$cmd FAILED"
    echo_debug "your test results are in $OUTFILE TODO^33 no they are not"
    exit # TODO: DELETE when it's time to play with other versions
done

# TODO: DELETE this script when done
