#!/usr/bin/env bash
# usually my first three guesses are %w[laugh cried stony]
#
# you generally want to run "editfirst cheat_at_wordle.bash" to edit this script changing the indivual letters in the
# variables and brackets below, then let it run to show you possible answers.
USUAL_UNUSED=qwpfjkzxvbm

UNUSED=qwpfkzxv
UNUSED=$USUAL_UNUSED

grep ^[ao$UNUSED][l$UNUSED]l[lao$UNUSED][lo$UNUSED]$ /usr/share/dict/words | grep o | grep a
