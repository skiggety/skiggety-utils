#!/usr/bin/env bash

# This script (...TODO, describe your script here, and DO_NOTooo_COMMIT until then.)

. $SKIGGETY_UTILS_DIR/lib/skiggety-utils.bash || exit 1

pushd $(dirname $0);git add -N $0;popd # XXoooX (COPPIPASTA)

interactive_develop_here 'TODO XXoooX: IMPLEMENT this script (COPPIPASTA)'
exit_with_error 'TODO XXoooX: TEST this script (COPPIPASTA)'
