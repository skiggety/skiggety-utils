. $SKIGGETY_UTILS_DIR/lib/vital.bash || exit_with_error 'could not include vital.bash'

# TODO: phase this out in favor of 'vital' and 'vital.bash'
TODAY_todo_DIR=${TODAY_todo_DIR:-"$HOME/today_todo"} # TODO: maybe help the user with place to change it in the bashrc template
export TODAY_todo_DIR
