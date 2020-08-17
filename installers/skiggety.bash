#!/usr/bin/env bash

# This script (... TODO TODO TODO explain )

THIS_DIR="$(cd "$(dirname $BASH_SOURCE)";pwd)"
. $THIS_DIR/../lib/skiggety-utils.bash || exit 1


function main {
    for arg in "$@"
    do
        shift
        case "$arg" in
            --non-interactive) set -- "$@" "-n" ;;
            *)                 set -- "$@" "$arg" ;;
        esac
    done

    # defaults
    interactive=true

    OPTIND=1
    while getopts ":inhi?" opt
    do
        case "$opt" in
            "i") interactive=true ;;
            "n") interactive=false ;;
            "h") exit_with_error "TODO: print usage" ;;
            "?") exit_with_error "TODO: print usage" ;;
            *) ;;
        esac
    done

    # set up bashrc
    if grep "^PATH_TO_SKIGGETY_UTILS=" ~/.bashrc
    # TOOD TODO: if contains_all_lines_in ~/.bashrc $TMP_BASHRC_SECTION # TODO: implement this function, which can use cat, sort, and uniq, and see if the linecount goes up
    then
        . ~/.bashrc
    else
        TMP_BASHRC="/tmp/bashrc.example.generated_by_SKIGGETY_UTILS.pid_$$"
        cat ~/.bashrc > $TMP_BASHRC # $TMP_BASHRC < ~/.bashrc
        PATH_TO_SKIGGETY_UTILS="$(cd "$(dirname $THIS_DIR)";pwd)"
        ESCAPED_PATH_TO_SKIGGETY_UTILS="$(echo $PATH_TO_SKIGGETY_UTILS | sed 's/\//\\\//g')"

        sed "s/\$HARDCODED_PATH_TO_SKIGGETY_UTILS/$ESCAPED_PATH_TO_SKIGGETY_UTILS/g"< $THIS_DIR/CONFIG/bashrc_section.bash >> $TMP_BASHRC
        . $TMP_BASHRC

        if $interactive
        then
            ask_user_to "vimdiff ~/.bashrc $TMP_BASHRC" || exit_with_error "User did not complete bashrc install"
            rm $TMP_BASHRC
        else
            echo_error "diff needed:"
            echo_error "\$ diff ~/.bashrc $TMP_BASHRC"
                           diff ~/.bashrc $TMP_BASHRC
            rm $TMP_BASHRC
            exit_with_error "Failed to modify ~/.bashrc because this is non-interactive mode. Please Re-run \"$THIS_DIR/../PWD_BIN/install\"."
        fi
    fi

    # set up bash_profile for macs
    if uname -a | grep Darwin > /dev/null
    then
        if ! grep bashrc ~/.bash_profile
        then
            MAC_BASH_PROFILE="$THIS_DIR/CONFIG/mac_bash_profile.bash"
            if $interactive
            then
                ask_user_to "vimdiff ~/.bash_profile $MAC_BASH_PROFILE" || exit_with_error "User did not complete bashrc install"
            else
                echo_error "diff needed:"
                echo_error "\$ diff ~/.bash_profile $MAC_BASH_PROFILE"
                               diff ~/.bash_profile $MAC_BASH_PROFILE
                exit_with_error "Failed to modify ~/.bash_profile because this is non-interactive mode. Please Re-run \"$THIS_DIR/../PWD_BIN/install\"."
            fi
        fi
    fi

}

main "$@"
