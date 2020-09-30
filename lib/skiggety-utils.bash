# TODO TODO: . $THIS_DIR/shelper.bash || exit 1 # TODO: extract & include shelper.bash which checks bash version

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
    local exit_status=$?
    local error_message="$*"

    if [ "$error_message" != "" ]; then
        echo_error "$error_message"
    fi
    cumulative_error_count=${cumulative_error_count:-0}
    cumulative_error_count=$(($cumulative_error_count+$exit_status))
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
    echo "!!!! exiting \"$(basename $0)\" because of $cumulative_error_count previously shown ERRORS"
    exit $cumulative_error_count
}

function echo_debug {
    echo "DEBUG: $*" >&2
}

function debug_eval_here {
    echo_debug "$(echo_eval $*)" "$(echo_callsite)"
}

function debug_eval {
    echo_debug "$(echo_eval $*)"
}

function debug_here {
    echo_debug "$* at \"${BASH_SOURCE[1]}\":${BASH_LINENO[0]}"
}

function echo_eval {
    if [[ $# -ne 1 ]]; then
        echo_error_here 'echo_eval nothing to evaluate'
    elif is_array_name $1; then
        local expr="\$(printf \"'%s' \" \"\${$1[@]}\")" # based on "https://stackoverflow.com/a/12985353/1735179"
        eval local val=$expr
        echo "$1=($val)"
    else
        local expr="\$$1"
        eval local val=$expr
        echo "$1='$val'"
    fi
}

# based on "https://stackoverflow.com/a/50938224/1735179":
function is_array_name {
    [[ $# -ne 1 ]] && return 2
    local var="$1"
    regex="^declare -[aA] ${var}(=|$)"
    [[ $(declare -p "$var" 2> /dev/null) =~ $regex ]]
}

function echo_error_here {
    echo "ERROR: $* ( $(echo_callsite) )" >&2
}

function echo_error {
    echo "ERROR: $*" >&2
}

function echo_divider_with_text {
    char="$1"
    text="$2"
    echo_divider_without_newline "$char"
    echo -ne "\r"
    echo_char_n_times "$char" 4
    echo " $text "
}

function echo_divider {
    char="$1"
    echo_divider_without_newline "$char"
    echo
}

function echo_divider_without_newline {
    char="$1"
    echo_char_n_times "$char" 80 # TODO TODO TODO: sense terminal width or default to 80
}

function echo_char_n_times {
    char="$1"
    n="$2"
    for ((i=1;i<=$n; i++)); do echo -n "$char"; done
}
