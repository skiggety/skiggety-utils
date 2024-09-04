# TODO: maybe help the user with place to change it in the bashrc template

VITAL_DIR=${VITAL_DIR:-"$HOME/vital"}
export VITAL_DIR

VITAL_REPORTS_DIR="${VITAL_DIR}/reports"
mkdir -p "$VITAL_REPORTS_DIR"
export VITAL_REPORTS_DIR

VITAL_REPORTS_ARCHIVE_DIR="${VITAL_REPORTS_DIR}/archive"
mkdir -p "$VITAL_REPORTS_ARCHIVE_DIR"
export VITAL_REPORTS_ARCHIVE_DIR

isotoday="$(isotoday)"
export isotoday

# TODO^16: change this to reflect the new name, 'vital'?:
vital_todo_list_file_name="TODO.today.txt" # IGNORE_TODO
export vital_todo_list_file_name
vital_todo_list_file_path="$VITAL_DIR/$vital_todo_list_file_name"
export vital_todo_list_file_path
vital_done_list_file_name="DONE.$isotoday.txt"
export vital_done_list_file_name
