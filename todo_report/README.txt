==== TODOs, ascending, so you know what's likely to change next. Do not edit, run 'generate_todo_report' to generate. ====
( showing last 8 lines out of 757 for 'todo': )
./README.md:128:      - TODO^111: (IN_PROGRESS) at least check out the repo, maybe with a skiggety-utils installer
./bin/crontab-verbose:20:    # TODO^111: (IN_PROGRESS) also open example files, if available (so 'firstlife' can suggest an example crontab file)
./bin/firstlife-morning:7:# - TODO^111: if a second firstlife pops up, maybe it should take over and the old one gracefully exits? (PPID in a marker file?)
./bin/firstlife-morning:6:# TODO^113: (IN_PROGRESS) have a way for a new instance and a running instance to avoid interfering. The new one could take over and the old one could exit gracefully.
./bin/templates/firstlife-morning.routine.TEMPLATE:39:exit_if_day_is_over # TODO^114: (IN_PROGRESS, NOW) # ; exit_if_this_script_is_running_elsewhere # after we make sure common tasks only run once, we could do this, like what ../*firstlife-status scripts do with $FIRSTLIFE_DIR/.review-firstlife-status_PPID
./bin/templates/firstlife-work.routine.TEMPLATE:21:firstlife-reward "looked at URGENT stuff" # TODO^114: (IN_PROGRESS) this is important, TEST against getting to this point (URGENT stuff done) as a benchmark
./README.md:130:  - TODO^115: move 'vital' data (to do list) to private repo (skiggety utils should help set up)
./bin/templates/firstlife-morning.routine.TEMPLATE:41:# FUN TODO^115: (IN_PROGRESS, NOW) do something like this, and use widely, so you can shedule the morning routine multiple times as a backup: delegate_once_daily 'make sure you have taken any morning medications' || accumulate_error 'did not medicate'
