# TODO: . $THIS_DIR/shelper.bash || exit 1      # TODO include shelper.bash which checks bash version

newline='
'

function echo_here {
    echo "at ${BASH_SOURCE[1]}:${BASH_LINENO[0]}"
}

function echo_callsite {
    echo "at ${BASH_SOURCE[2]}:${BASH_LINENO[1]}"
}

function exit_with_error {
    echo "exiting $(basename $0) on ERROR: $* ( $(echo_callsite) )" >&2
    exit 1
}

function accumulate_error {
    local error_message="$*"

    echo_error "$error_message"
    cumulative_error_count=${cumulative_error_count:-0}
    cumulative_error_count=$(($cumulative_error_count+1))
}

function exit_with_any_accumulated_errors {
    if [ -z "$cumulative_error_count" ]; then
        exit 0
    elif [ "0" -eq "$cumulative_error_count" ]; then
        exit 0
    else
        exit_with_accumulated_errors
    fi
}

function exit_with_accumulated_errors {
    echo "exiting \"$(basename $0)\" because of $cumulative_error_count previously shown ERRORS"
    exit $cumulative_error_count
}

function echo_debug {
    echo "DEBUG: $*" >&2
}

function debug_eval {
    echo_debug "$(echo_eval $*)"
}

function debug_eval_here {
    echo_debug "$(echo_eval $*)" "$(echo_callsite)"
}

function debug_here {
    echo_debug "$* at \"${BASH_SOURCE[1]}\":${BASH_LINENO[0]}"
    # TODO: echo_debug "$* $(echo_callsite)
}

function echo_eval {
    expr="\$$1"
    eval val=$expr
    echo "$1='$val'"
}

function echo_error_here {
    echo "ERROR: $* ( $(echo_callsite) )" >&2
}

function echo_error {
    echo "ERROR: $*" >&2
}

# debug_eval_here "PATH"
# which dashboard
