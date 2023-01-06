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

    # set up bash_profile for macs
    if uname -a | grep Darwin > /dev/null; then
        if ! grep bashrc ~/.bash_profile > /dev/null; then
            MAC_BASH_PROFILE="$THIS_DIR/skiggety.bash.config/mac_bash_profile.bash"
            if $interactive; then
                $THIS_DIR/../bin/ask_user "vimdiff ~/.bash_profile $MAC_BASH_PROFILE" || exit_with_error "User did not complete bashrc install"
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
        TMP_BASHRC="/tmp/bashrc.example.generated_by_SKIGGETY_UTILS.pid_$$"
        grep -v FROM_SKIGGETY_UTILS ~/.bashrc > $TMP_BASHRC # $TMP_BASHRC < ~/.bashrc
        SKIGGETY_UTILS_DIR="$(cd "$(dirname $THIS_DIR)";pwd)"
        SKIGGETY_UTILS_DIR="${SKIGGETY_UTILS_DIR/$HOME/\$HOME}"
        ESCAPED_SKIGGETY_UTILS_DIR="$(echo $SKIGGETY_UTILS_DIR | sed 's/\//\\\//g')"

        echo >> $TMP_BASHRC
        sed "s/\$HARDCODED_SKIGGETY_UTILS_DIR/$ESCAPED_SKIGGETY_UTILS_DIR/g"< "$NEW_BASHRC_SECTION" >> $TMP_BASHRC
        . $TMP_BASHRC

        if $interactive; then
            $THIS_DIR/../bin/ask_user "Make suggested .bashrc edits, using a command such as: \"vimdiff -o ~/.bashrc $TMP_BASHRC\"" || exit_with_error "User did not complete bashrc install"
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
