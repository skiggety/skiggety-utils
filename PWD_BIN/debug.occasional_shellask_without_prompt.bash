#!/usr/bin/env bash

# This script (...TODO, describe your script here)

. $SKIGGETY_UTILS_DIR/lib/skiggety-utils.bash || exit 1
SKIGGETY_DEBUG=true

mkdir -p logs
LOG="logs/occasional_shellask_without_prompt.debug_log.$(date +'%Y-%m-%d_%T_%z').txt"

test_num=0
success_count=0
failure_count=0
debug_eval test_num
while [ $test_num -lt 10 ]; do # TODO: add zeros
    debug_eval test_num
    if shellask "test number $test_num: did you get a prompt?";then
        SKIGGETY_BLINKY_DEBUG=true # TODO: put this right above where you want to draw focus
        debug_here
        SKIGGETY_BLINKY_DEBUG=false # TODO: put this right below where you want to draw focus
        success_count="$(( $success_count + 1 ))"
    else
        SKIGGETY_BLINKY_DEBUG=true # TODO: put this right above where you want to draw focus
        debug_here
        SKIGGETY_BLINKY_DEBUG=false# TODO: put this right below where you want to draw focus
        failure_count="$(( $failure_count + 1 ))"
        # TODO: LOG ERROR!!!
    fi

    test_num="$(( $test_num + 1 ))"
done

debug_eval success_count
echo "$success_count successes" >> $LOG

debug_eval failure_count
echo "$failure_count failures" >> $LOG


