# TODO: maybe help the user with place to change it in the bashrc template
VITAL_DIR=${VITAL_DIR:-"$HOME/today_todo"} # TODO^6: change default location to "$HOME/vital"
export VITAL_DIR

isotoday="$(isotoday)"
export isotoday

vital_todo_list_file_name="TODO.today.txt" # IGNORE_TODO
export vital_todo_list_file_name
vital_todo_list_file_path="$VITAL_DIR/$vital_todo_list_file_name"
export vital_todo_list_file_path
vital_done_list_file_name="DONE.$isotoday.txt"
export vital_done_list_file_name
