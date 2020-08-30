#!/usr/bin/env bash

# This script (... TODO TODO TODO explain )

THIS_DIR="$(cd "$(dirname $BASH_SOURCE)";pwd)"
. $THIS_DIR/../lib/skiggety-utils.bash || exit 1

# TODO TODO: install custom list app (opens dedicated browser window "as an app") (huh?)
# TODO TODO: hook up to google drive
# TODO: collect data on email inbox, etc. and auto-generate graphs for the dashboard
# TODO TODO TODO: music rotator thingy
# TODO TODO: (and a music player of some sort)
# TODO: "playbot", a program that tunes in youtube livestreams, video meetings, watch later, podcasts and your personal dashboards, automatically. Great as an information radiator.
# TODO: install/config chrome tab scheduler and/or other stuff to enable a some kind of dashboard in a web browswer


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
    if grep "^export PATH_TO_SKIGGETY_UTILS=" ~/.bashrc > /dev/null
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
            $THIS_DIR/../bin/ask_user_to "vimdiff ~/.bashrc $TMP_BASHRC" || exit_with_error "User did not complete bashrc install"
            rm $TMP_BASHRC
        else
            echo
            echo_error_here "diff needed:"
            echo_error_here "\$ diff ~/.bashrc $TMP_BASHRC"
                                diff ~/.bashrc $TMP_BASHRC
            echo
            rm $TMP_BASHRC
            exit_with_error "Failed to modify ~/.bashrc because this is non-interactive mode. Please Re-run \"$THIS_DIR/../PWD_BIN/install_me\"."
        fi
    fi

    # set up bash_profile for macs
    if uname -a | grep Darwin > /dev/null
    then
        if ! grep bashrc ~/.bash_profile > /dev/null
        then
            MAC_BASH_PROFILE="$THIS_DIR/CONFIG/mac_bash_profile.bash"
            if $interactive
            then
                $THIS_DIR/../bin/ask_user_to "vimdiff ~/.bash_profile $MAC_BASH_PROFILE" || exit_with_error "User did not complete bashrc install"
            else
                echo_error_here "diff needed:"
                echo_error_here "\$ diff ~/.bash_profile $MAC_BASH_PROFILE"
                                    diff ~/.bash_profile $MAC_BASH_PROFILE
                exit_with_error "Failed to modify ~/.bash_profile because this is non-interactive mode. Please Re-run \"$THIS_DIR/../PWD_BIN/install_me\"."
            fi
        fi
    fi

}

main "$@"
