#!/usr/bin/env bash

# This script is merely a way to control where and how and how often to run demo_python_version_hack &
# demo_ruby_version_hack to do whatever testing I need to do. And control where the output goes, etc.

. $SKIGGETY_UTILS_DIR/lib/skiggety-utils.bash || exit 1
SKIGGETY_DEBUG = true

# TODO^31: call this from your local PWD/experiment.gitignored.bash on all machines that want to
# participate in debugging.

# TODO^31: ask_user "debug the rest of $0"
exit

# go where there's no accurate .python-version to rely on to put these version hacks to the test:
cd ~/today_todo/; duh # to make it easier to diff output on two machines
for cmd in demo_python_version_hack \
           demo_ruby_version_hack
do
    # XXX TODO^31: tee everything in here:
    # TODO: try ask_user congrats, you are in a debugger at TODO_current_script_name_and_line_number_TODO
    debug_here "running: '$cmd'"
    # XXX TODO^27: learn to use the damned vim copy/paste buffers better for lines like this:
    $cmd >$cmd.gitignored.output.txt || exit_with_error "$cmd FAILED"
done

# TODO: DELETE this script when done
