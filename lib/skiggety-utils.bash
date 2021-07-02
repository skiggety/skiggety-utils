# TODO TODO: . $THIS_DIR/shelper.bash || exit 1 # TODO TODO: extract & include shelper.bash which checks bash version, and provides utility functions. Figure out how to distribute it as a shell library.

newline='
'

function echo_here {
    echo "$*" "at ${BASH_SOURCE[1]}:${BASH_LINENO[0]}"
}

function echo_callsite {
    echo "at ${BASH_SOURCE[2]}:${BASH_LINENO[1]}"
}

function echo_parent_callsite {
    echo "at ${BASH_SOURCE[3]}:${BASH_LINENO[2]}"
}

function exit_with_error {
    echo "exiting $(basename $0) on ERROR: $* ( $(echo_callsite) )" >&2
    exit 1
}

function accumulate_error {
    local exit_status=$?
    if [ "$exit_status" == "0" ]; then
        exit_status=1
    fi
    local error_message="$*"

    if [ "$error_message" != "" ]; then
        echo_error_callsite "$error_message"
    fi
    cumulative_error_count=${cumulative_error_count:-0}
    cumulative_error_count=$(($cumulative_error_count+$exit_status))
}

function exit_if_any_accumulated_errors {
    if ! [ -z "$cumulative_error_count" ]; then
        exit_with_accumulated_errors
    fi
}

function exit_with_accumulated_errors {
    echo_divider_with_text "!" "EXITING \"$(basename $0)\" because of $cumulative_error_count previously shown ERRORS"
    exit $cumulative_error_count
}

# TODO TODO TODO: consistent debug function names

SKIGGETY_DEBUG=${SKIGGETY_DEBUG:-false}

function echo_debug {
    if $SKIGGETY_DEBUG; then
        echo "DEBUG: $*" >&2
    fi
}

function debug_here {
    echo_debug "$* $(echo_callsite)"
}

function debug_eval {
    echo_debug "$(echo_eval $*)"
}

function debug_eval_here {
    echo_debug "$(echo_eval $*)" "$(echo_callsite)"
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

function echo_error_callsite {
    echo_error "$* ( $(echo_parent_callsite) )"
}

function echo_error_here {
    echo_error "$* ( $(echo_callsite) )"
}

# TODO TODO TODO: colorize output when appropriate:
function echo_error {
    echo "ERROR: $*" >&2
}

function echo_divider_with_text {
    pattern="$1"
    text="$2"
    echo_divider_without_newline "$pattern"
    echo -ne "\r"
    echo_pattern_n_length "$pattern" 4
    echo " $text "
}

function echo_divider {
    pattern="$1"
    echo_divider_without_newline "$pattern"
    echo
}

# for divider length, use last value, or current column count, or 80. Using last value over current means you might have to restart a review commond or other program for dividers to look perfect after resizing a terminal, but it also means that commands run inside review will fill the terminal properly instead of sensing 80
calc_columns="$(tput cols)"
calc_columns="${calc_columns:-80}"
export SKIGGETY_DIVIDER_LENGTH="${SKIGGETY_DIVIDER_LENGTH:-$calc_columns}"

function echo_divider_without_newline {
    pattern="$1"
    echo_pattern_n_length "$pattern" "$SKIGGETY_DIVIDER_LENGTH"
}

function echo_pattern_n_length {
    pattern="$1"
    n="$2"
    pattern_length="${#pattern}"
    repeats="$(( $n / $pattern_length))"
    remainder="$(( $n % $pattern_length))"
    for ((i=1;i<=$repeats; i++)); do echo -n "$pattern"; done
    echo -n "${pattern:0:$remainder}"
}

function assert_equal {
    EXPECTED="$1"
    RECEIVED="$2"
    if [ "$EXPECTED" = "$RECEIVED" ]; then
        echo_debug "assert_equal SUCCESS! (value was: \"$RECEIVED\")"
    else
        echo_error_callsite "assert_equal FAILED:"
        diff -u --label expected <(echo "$EXPECTED") --label received <(echo "$RECEIVED") >&2
        exit 1
    fi
}
