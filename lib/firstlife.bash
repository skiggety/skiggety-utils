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

function exit_if_script_succeeded_today {
    THIS_SCRIPT_RAN_MARKER_FILE="$(succeeded_today_marker_script $1)"
    if [ -f $THIS_SCRIPT_RAN_MARKER_FILE ]; then
        echo "'$(basename $1)' already succeeded today ($FIRSTLIFE_ISOTODAY), exiting without error..."
        exit 0
    fi
}

function mark_script_succeeded_today {
    THIS_SCRIPT_RAN_MARKER_FILE="$(succeeded_today_marker_script $1)"
    mkdir -p "$(dirname $THIS_SCRIPT_RAN_MARKER_FILE)"
    debug_here "marking morning routine done with command: touch $THIS_SCRIPT_RAN_MARKER_FILE"
    touch $THIS_SCRIPT_RAN_MARKER_FILE
}

function succeeded_today_marker_script {
 echo "$FIRSTLIFE_DIR/markers/$(basename $1).succeeded_on_${FIRSTLIFE_ISOTODAY}"
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

    echo "...starting '$nickname' routine..."
    if [ -f $PERSONAL_ROUTINE_SCRIPT ]; then
        INNER_ROUTINE_SCRIPT="$PERSONAL_ROUTINE_SCRIPT"
    elif [ -f $TEMPLATE_ROUTINE_SCRIPT ];then
        INNER_ROUTINE_SCRIPT="$TEMPLATE_ROUTINE_SCRIPT"
    else
        exit_with_error "Inner $nickname routine not found $(echo_here) (neither '$PERSONAL_ROUTINE_SCRIPT' nor '$TEMPLATE_ROUTINE_SCRIPT' )"
    fi

    $INNER_ROUTINE_SCRIPT \
        && firstlife-reward "completed $INNER_ROUTINE_SCRIPT" \
        || accumulate_error "inner $nickname routine '$INNER_ROUTINE_SCRIPT' FAILED"

    # TODO^88: (IN_PROGRESS NOW): allow using vscode here:
    if [ -f $PERSONAL_ROUTINE_SCRIPT ]; then
        shellask "Want to tune up $(basename $PERSONAL_ROUTINE_SCRIPT) for next time?" \
            && vimdiff -o $TEMPLATE_ROUTINE_SCRIPT $PERSONAL_ROUTINE_SCRIPT # TODO^2: GTVO (get the vim out)
    else
        shellask "Would you like to start maintaining a local script for your $nickname routine?" \
            && cp $TEMPLATE_ROUTINE_SCRIPT $PERSONAL_ROUTINE_SCRIPT \
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
  echo '|------*==========================*------------------------|'
  echo '|------|                          |------------------------|'
  echo '|------|  Please Photograph this  |------------------------|'
  echo '|------|  (outer) box, not        |------------------------|'
  echo '|------|  including anything      |------------------------|'
  echo '|------|  outside the box, to     |------------------------|'
  echo '|------|  satisfy your alarmy     |------------------------|'
  echo '|------|  mission.                |------------------------|'
  echo '|------|                          |------------------------|'
  echo '|------|==========================|------------------------|'
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
