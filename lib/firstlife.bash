FIRSTLIFE_DIR=${FIRSTLIFE_DIR:-"$HOME/firstlife"}
export FIRSTLIFE_DIR

FIRSTLIFE_BIN=${FIRSTLIFE_BIN:-"$FIRSTLIFE_DIR/bin"}
export FIRSTLIFE_BIN

FIRSTLIFE_LOG_DIR=${FIRSTLIFE_LOG_DIR:-"$FIRSTLIFE_DIR/log"}
export FIRSTLIFE_LOG_DIR

FIRSTLIFE_ISOTODAY=${FIRSTLIFE_ISOTODAY:-"$(isotoday)"}
export FIRSTLIFE_ISOTODAY

function log_file_for_type {
    log_type="$1"
    echo "${FIRSTLIFE_LOG_DIR}/${log_type}.${FIRSTLIFE_ISOTODAY}.log.txt"
}

function is_still_today {
    if [ "$FIRSTLIFE_ISOTODAY" == "$(isotoday)" ]; then
        return 0
    else
        return 1
    fi

    exit_with_error 'should never get here'
}

function is_another_day {
    if is_still_today; then
        return 1
    else
        return 0
    fi
}

# EASY TODO^77: TEST and use 'is_another_day' and/or 'exit_if_day_is_over' liberally, including in live.gitignored.bash
function exit_if_day_is_over {
    if is_another_day; then
        echo "The day (${FIRSTLIFE_ISOTODAY}) has ended, exiting $(basename $0)"
        exit_with_any_accumulated_errors
        exit 0
    fi
}

function personal_inner_routine_script {
    echo "$FIRSTLIFE_BIN/$(personal_inner_routine_script_name $1)"
}

function personal_inner_routine_script_name {
    echo "$(basename $1).routine.$(whoami)"
}

function template_inner_routine_script {
    echo "$SKIGGETY_UTILS_DIR/bin/templates/$(template_inner_routine_script_name $1)"
}

function template_inner_routine_script_name {
    echo "$(basename $1).routine.TEMPLATE"
}
