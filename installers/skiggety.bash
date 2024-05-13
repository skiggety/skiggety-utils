#!/usr/bin/env bash

# This script sets up my bash environment the way I like it.

# TODO^2?: reload bashrc after setting it up?

THIS_DIR="$(cd "$(dirname $BASH_SOURCE)";pwd)"
. $THIS_DIR/../lib/skiggety-utils.bash || exit 1

function main {
    debug_here "Setting up $(basename $0)"

    for arg in "$@"; do
        shift
        case "$arg" in
            --non-interactive) set -- "$@" "-n" ;;
            *)                 set -- "$@" "$arg" ;;
        esac
    done

    # defaults
    interactive=true

    OPTIND=1
    while getopts ":inhi?" opt; do
        case "$opt" in
            "i") interactive=true ;;
            "n") interactive=false ;;
            "h") exit_with_error "TODO: print usage" ;;
            "?") exit_with_error "TODO: print usage" ;;
            *) ;;
        esac
    done

    # TODO^4: check for marker file to avoid re-running, like in './basic_prerequisites'
    # set up bash_profile for macs
    if uname -a | grep Darwin > /dev/null; then
        if ! grep bashrc ~/.bash_profile > /dev/null; then
            MAC_BASH_PROFILE="$THIS_DIR/skiggety.bash.config/mac_bash_profile.bash"
            if $interactive; then
                $THIS_DIR/../bin/shellask "vimdiff ~/.bash_profile $MAC_BASH_PROFILE" || exit_with_error "User did not complete bashrc install"
            else
                echo_error_here "diff needed:"
                echo_error_here "\$ diff ~/.bash_profile $MAC_BASH_PROFILE"
                                    diff ~/.bash_profile $MAC_BASH_PROFILE
                exit_with_error "Failed to modify ~/.bash_profile because this is non-interactive mode. Please Re-run \"$THIS_DIR/../PWD_BIN/install-skiggety-utils\"."
            fi
        fi
    fi

    # set up bashrc
    NEW_BASHRC_SECTION="$THIS_DIR/skiggety.bash.config/bashrc_section.bash"
    expected_bashrc_uniq_lines=$(( 1 + $(sort < ~/.bashrc | uniq | wc -l) )) # adding one because one HARDCODED value will be changed
    projected_bashrc_uniq_lines=$(( $(cat ~/.bashrc $NEW_BASHRC_SECTION | sort | uniq | wc -l)  ))
    if [ $expected_bashrc_uniq_lines == $projected_bashrc_uniq_lines ]; then
        . ~/.bashrc
    else
        TMP_BASHRC="/tmp/skiggety_suggested_bashrc.pid_$$"
        grep -v FROM_SKIGGETY_UTILS ~/.bashrc > $TMP_BASHRC # $TMP_BASHRC < ~/.bashrc
        SKIGGETY_UTILS_DIR="$(cd "$(dirname $THIS_DIR)";pwd)"
        SKIGGETY_UTILS_DIR="${SKIGGETY_UTILS_DIR/$HOME/\$HOME}"
        ESCAPED_SKIGGETY_UTILS_DIR="$(echo $SKIGGETY_UTILS_DIR | sed 's/\//\\\//g')"

        # TODO^60: (IN_PROGRESS) also make sure Zerothlife takes care of it itself, asking the user to put it in their bashrc
        ZEROTHLIFE_DIR="\$HOME/zerothlife"
        debug_eval ZEROTHLIFE_DIR
        ESCAPED_ZEROTHLIFE_DIR="$(echo $ZEROTHLIFE_DIR | sed 's/\//\\\//g')"
        debug_eval ESCAPED_ZEROTHLIFE_DIR

        ZEROTHLIFE_CODE_DIR="\$HOME/code/zerothlife"
        debug_eval ZEROTHLIFE_CODE_DIR
        ESCAPED_ZEROTHLIFE_CODE_DIR="$(echo $ZEROTHLIFE_CODE_DIR | sed 's/\//\\\//g')"
        debug_eval ESCAPED_ZEROTHLIFE_CODE_DIR

        echo >> $TMP_BASHRC
        sed "s/\$HARDCODED_SKIGGETY_UTILS_DIR/$ESCAPED_SKIGGETY_UTILS_DIR/g"< "$NEW_BASHRC_SECTION" | sed "s/\$HARDCODED_ZEROTHLIFE_DIR/$ESCAPED_ZEROTHLIFE_DIR/g" | sed "s/\$HARDCODED_ZEROTHLIFE_CODE_DIR/$ESCAPED_ZEROTHLIFE_CODE_DIR/g" >> $TMP_BASHRC
        . $TMP_BASHRC

        if $interactive; then
            $THIS_DIR/../bin/shellask "Ready to make suggested .bashrc edits with a vimdiff?" && vimdiff ~/.bashrc $TMP_BASHRC || \
                $THIS_DIR/../bin/shellask "Make suggested .bashrc edits, using an alternative or a command such as: \"vimdiff ~/.bashrc $TMP_BASHRC\"" || \
                exit_with_error "User did not complete .bashrc configuration"
            rm $TMP_BASHRC
        else
            echo
            echo_error_here "diff needed for '~/.bashrc':"
                                diff ~/.bashrc $TMP_BASHRC
            echo
            rm $TMP_BASHRC
            exit_with_error "Failed to modify ~/.bashrc because this is non-interactive mode. Please Re-run \"$THIS_DIR/../PWD_BIN/install-skiggety-utils\"."
        fi
    fi

    true

}

main "$@"
