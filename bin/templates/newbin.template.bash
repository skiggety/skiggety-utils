#!/usr/bin/env bash

# This script (...TODO, describe your script here, and DO_NOTooo_COMMIT until then.)

. $SKIGGETY_UTILS_DIR/lib/skiggety-utils.bash || exit 1

XoooXX_THINGY=''
while [[ "$1" == -* ]]; do
    if [ "$1" == '-x' ] || [ "$1" == '--XoooXX' ]; then
        XoooXX_THINGY='whatever DO_NOT_COMoooMIT'
        shift
    fi
done

pushd $(dirname $0);git add -N $0;popd # XXoooX (COPPIPASTA)

interactive_develop_here 'TODO XXoooX: IMPLEMENT this script (COPPIPASTA)'
exit_with_error 'TODO XXoooX: TEST this script (COPPIPASTA)'
