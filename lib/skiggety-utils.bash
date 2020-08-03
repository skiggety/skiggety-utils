# TODO: . $THIS_DIR/shelper.bash || exit 1      # TODO include shelper.bash which checks bash version

function exit_with_error {
    echo "exiting $(basename $0) on ERROR: $* ( $(echo_callsite) )" >&2
    exit 1
}

function echo_callsite {
    echo "at ${BASH_SOURCE[2]}:${BASH_LINENO[1]}"
}

function echo_here {
    echo "at ${BASH_SOURCE[1]}:${BASH_LINENO[0]}"
}

function echo_eval {
    expr="\$$1"
    eval val=$expr
    echo "$1='$val'"
}

function echo_debug {
    echo "DEBUG: $*" >&2
}

function debug_eval_here {
    echo_debug "$(echo_eval $*)" "$(echo_callsite)"
}

function debug_eval {
    echo_debug "$(echo_eval $*)"
    # TODO: echo_debug "$* $(echo_callsite)
}

function debug_here {
    echo_debug "$* at \"${BASH_SOURCE[1]}\":${BASH_LINENO[0]}"
    # TODO: echo_debug "$* $(echo_callsite)
}

function echo_error {
    echo "ERROR: $* ( $(echo_callsite) )" >&2
}

# debug_eval_here "PATH"
# which dashboard
