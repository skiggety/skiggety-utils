FIRSTLIFE_DIR=${FIRSTLIFE_DIR:-"$HOME/firstlife"}
export FIRSTLIFE_DIR

# TODO: when this is in it's own repo this will not be based on skiggety-utils:
FIRSTLIFE_CODE_DIR="$SKIGGETY_UTILS_DIR"
export FIRSTLIFE_CODE_DIR

FIRSTLIFE_BIN=${FIRSTLIFE_BIN:-"$FIRSTLIFE_DIR/bin"}
export FIRSTLIFE_BIN

FIRSTLIFE_LOG_DIR=${FIRSTLIFE_LOG_DIR:-"$FIRSTLIFE_DIR/log"}
export FIRSTLIFE_LOG_DIR

FIRSTLIFE_MARKER_DIR="$FIRSTLIFE_DIR/markers"
export FIRSTLIFE_MARKER_DIR

FIRSTLIFE_ISOTODAY=${FIRSTLIFE_ISOTODAY:-"$(isotoday)"}
export FIRSTLIFE_ISOTODAY

# Including the date in mute file names so they only work for one day even if they get left around by accident:
FIRSTLIFE_MUTE_FILE_PREFIX="$FIRSTLIFE_MARKER_DIR/.firstlife_currently_muted_on.${FIRSTLIFE_ISOTODAY}.by_pid."
export FIRSTLIFE_MUTE_FILE_PREFIX

FIRSTLIFE_THIS_SCRIPT_PID_FILE="$FIRSTLIFE_MARKER_DIR/.current.$(basename $0).PID"
touch $FIRSTLIFE_THIS_SCRIPT_PID_FILE
export FIRSTLIFE_THIS_SCRIPT_PID_FILE

# TODO^4: function seconds_as_hms { # for use in sleep-verbose, so '3627' seconds would be '1:00:27'

function log_file_for_type {
    log_type="$1"
    echo "${FIRSTLIFE_LOG_DIR}/${log_type}.$(isotoday).log.txt"
}

function is_still_today {
    if [ "$FIRSTLIFE_ISOTODAY" == "$(isotoday)" ]; then
        return 0
    else
        return 1
    fi

    exit_with_error 'should never get here'
}

function firstlife-preempt-same-script {
    debug_here
    echo $$ > $FIRSTLIFE_THIS_SCRIPT_PID_FILE
}

# TODO^113: use firstlife_exit_if_needed liberally instead of exit_if_day_is_over (all over the codebase)
function firstlife_exit_if_needed {
    exit_if_day_is_over
    exit_if_this_script_is_running_elsewhere
}

# after we make sure common tasks only run once, we could do this, like what ../*firstlife-status scripts do with $FIRSTLIFE_MARKER_DIR/.review-firstlife-status_PID
function exit_if_this_script_is_running_elsewhere {
    debug_here
    latest_script_pid='0'
    if [ -f $FIRSTLIFE_THIS_SCRIPT_PID_FILE ]; then
        latest_script_pid="$(cat $FIRSTLIFE_THIS_SCRIPT_PID_FILE)"
    fi
    debug_eval_here latest_script_pid
    debug_here "\$\$ is '$$'"
    if [ $$ -ne $latest_script_pid ]; then
        accumulate_error "Another instance of $(basename $0) is running, exiting..."
        exit_with_any_accumulated_errors
    fi
}

function exit_if_day_is_over {
    if is_another_day; then
        accumulate_error "The day (${FIRSTLIFE_ISOTODAY}) has ended, exiting $(basename $0)"
        exit_with_any_accumulated_errors
    fi
}

function is_another_day {
    if is_still_today; then
        return 1
    else
        return 0
    fi
}

# TODO^100: DEBUG false positives on morning routine, in other words this thinks it has finished when it hasn't:
function exit_if_script_succeeded_today {
    THIS_SCRIPT_RAN_MARKER_FILE="$(succeeded_today_marker_script $1)"
    if [ -f $THIS_SCRIPT_RAN_MARKER_FILE ]; then
        echo "'$(basename $1)' already succeeded today ($FIRSTLIFE_ISOTODAY), exiting without error..."
        exit 0
    fi
}

function has_routine_succeeded_today {
    SUCCESS_TODAY_MARKER_FILE="$(succeeded_today_marker_script $1)"
    if is_another_day; then
        return 1 # false
    fi
    if [ -f $SUCCESS_TODAY_MARKER_FILE ]; then
        return 0 # true
    else
        return 1 # false
    fi
}

function mark_script_succeeded_today {
    THIS_SCRIPT_RAN_MARKER_FILE="$(succeeded_today_marker_script $1)"
    mkdir -p "$(dirname $THIS_SCRIPT_RAN_MARKER_FILE)"
    debug_here "marking routine done with command: touch $THIS_SCRIPT_RAN_MARKER_FILE"
    touch $THIS_SCRIPT_RAN_MARKER_FILE
}

function succeeded_today_marker_script {
 echo "$FIRSTLIFE_MARKER_DIR/$(basename $1).succeeded_on_${FIRSTLIFE_ISOTODAY}"
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

function use_and_maintain_inner_routine_based_on_template {
    nickname="$1"
    outer_script="$2"

    PERSONAL_ROUTINE_SCRIPT="$(personal_inner_routine_script $outer_script)"
    TEMPLATE_ROUTINE_SCRIPT="$(template_inner_routine_script $outer_script)"

    # default to something that will fail so it would fail if you didn't find a real one and it got called somehow:
    INNER_ROUTINE_SCRIPT='false'

    if [ -f $PERSONAL_ROUTINE_SCRIPT ]; then
        INNER_ROUTINE_SCRIPT="$PERSONAL_ROUTINE_SCRIPT"
    elif [ -f $TEMPLATE_ROUTINE_SCRIPT ];then
        INNER_ROUTINE_SCRIPT="$TEMPLATE_ROUTINE_SCRIPT"
    else
        exit_with_error "Inner $nickname routine not found $(echo_here) (neither '$PERSONAL_ROUTINE_SCRIPT' nor '$TEMPLATE_ROUTINE_SCRIPT' )"
    fi

    echo "...starting '$nickname' routine..."
    $INNER_ROUTINE_SCRIPT \
        && firstlife-reward "completed $INNER_ROUTINE_SCRIPT" \
        || accumulate_error "inner $nickname routine '$INNER_ROUTINE_SCRIPT' FAILED"

    # TODO^88: allow using vscode here:
    if [ -f $PERSONAL_ROUTINE_SCRIPT ]; then # TODO^11: and if the files are different, otherwise probably not worth editing:
        # TODO^3: Encourage editing more strongly if the template has been edited more recently than the local version
        shellask "Want to tune up $(basename $PERSONAL_ROUTINE_SCRIPT) for next time?" \
            && vimdiff -o $TEMPLATE_ROUTINE_SCRIPT $PERSONAL_ROUTINE_SCRIPT # TODO^2: GTVO (get the vim out)
    else
        shellask "Would you like to start maintaining a local script for your $nickname routine?" \
            && mkdir -p $FIRSTLIFE_BIN \
            && cp $TEMPLATE_ROUTINE_SCRIPT $PERSONAL_ROUTINE_SCRIPT \
            && chmod +x $PERSONAL_ROUTINE_SCRIPT \
            && shellask "Edit $PERSONAL_ROUTINE_SCRIPT as you like for next time"
    fi
}

# Show an image for your alarm to match to, first thing:
function handle-alarmy-photo-mission {
  shellask "Please fullscreen this terminal window if you have an alarm to satisfy, otherwise say 'nope'" || return 1
  echo '|<--------125-characters-wide---------------------------------------------------------------------------------------------->|'
  shellask "use CTRL/COMMAND-plus/minus to change font size so the 125-character wide bar above just barely fits"
  echo '*==========================================================*'
  echo '|----------------------------------------------------------|'
  echo '|----------------------------------------------------------|'
  echo '|------*==========================================*--------|'
  echo '|------|                                          |--------|'
  echo '|------|  Please Photograph this (outer) box,     |--------|'
  echo '|------|  not including anything outside the      |--------|'
  echo '|------|  box, to satisfy your alarmy mission.    |--------|'
  echo '|------|                                          |--------|'
  echo '|------|  TO GET THIS IMAGE TO APPEAR, run:       |--------|'
  echo '|------|      firstlife-wake                      |--------|'
  echo '|------|                                          |--------|'
  echo '|------|==========================================|--------|'
  echo '|----------------------------------------------------------|'
  echo '|----------------------------------------------------------|'
  echo '|----------------------------------------------------------|'
  echo '*==========================================================*'
  firstlife-delegate --with-reward "take a photo of this screen to satisfy your alarmy mission" || return 1
  clear
  echo; echo
  echo 'You may now un-fullscreen and/or resize window as you please'
  sleep-verbose 3
  return 0
}

function make_terminal_big {
    # TODO^3: develop generic way to bump up the font size for emphasis, use as needed
    # TODO^4: set size according to config/preference:
    if is_on_mac_os; then
        osascript -e "tell application \"Terminal\" to set the font size of front window to 16"
    else
        shellask "TODO: IMPLEMENT make_terminal_big for this os/terminal, or at least vote $(echo_here)"
        exit_with_error "NOT IMPLEMENTED"
    fi
}

REWARD_LOG="$(log_file_for_type reward)"
debug_eval_here REWARD_LOG
export REWARD_LOG
