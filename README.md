# skiggety-utils

My collection of convenience scripts and configuration

This is top-down programming from the very top. The first thing I do on a new computer should be to check this out and run it. It should be flexible enough that other people with different preferences can use it too, but the core mission is for myself. Once run, I should have my programs and utilities set up.

How to get started:
===================

There are two options, a docker demo to try it safely, or a normal mode to install skiggety-utils and other preferrred
software on your machine. For the safe docker demo:

- Open a terminal
- cd to this directory (where you checked out or downloaded this project)
- run "./demo_in_docker"
  - Follow the prompts, instructions, and read the output. By the end, you should know what's going on.

- Open a terminal
- cd to this directory (where you checked out or downloaded this project)
- run "./start"
  - Follow the prompts, instructions, and read the output. By the end, you should know what's going on.

Core Design Decisions and Questions:
======================

  - This project uses, and helps the user use, several programming languages, since this project is a spawning ground for other projects.
  - There will be a bias towards certain tools that I prefer to use, but I'll try to make it as unobtrusive as possible. If you use bash and vim you will find extra goodies to make your life easier here, but if not there's still plenty here for you. I'm currently developing on a mac and doing some testing on a linux box, so there is bias from that, too.
  - "./PWD_BIN" should be in the user's in the PATH, which allows you to cd into a directory and run commands with simple technology-agnostic names, like "dashboard", "build", "precommit", "unit-test", "run", etc. Of course, this is scary because the meaning of these commands is changind depending on what local directory you're in, and you could run something you don't expect. To mitigate this concern, this will be configured with confirmation from the user, and PWD_BIN is a name chosen to conspicuously convey it's purpose.
    - TODO^5: figure out how to tack one git repo on to another so you don't have ./PWD_BIN always showing up in the
      uncommitted files in other git repos
    - (?) How can I make this safer? (TODO^4: probably should use direnv: "https://direnv.net/docs/hook.html") Put ./users_safeword/../PWD_BIN" in the path instead? make everything in PWD a subcommand of some other command? Come up with some handy way to add/remove it from the path quickly (or add it temporarily)? I put skiggety-utils/PWD_BIN_FIREWALL in your path before ./PWD_BIN if I wanted to block certain things
  - This project uses and enables TODO's in code, ranked so that "TODO TODO" is equal to "TODO^2" and outranks "TODO". This way you can easily add a vote when something becomes and impediment or whatever, and the cream will rise to the top. The "todo" program is a key part of this and is shown in the "default_dashboard". You can also put "IGNORE_TODO" on the same line as "TODO" if you want to mention "TODO" without it being on the list (like this).

Cool Programs you'll find in here:
==================================

- [demo_in_docker](./demo_in_docker) - try skiggety-utils in a safe sandbox!
- [duh](bin/duh) - Show Directory, Username, and Hostname (in scp format). Useful in prompts.
- [default_dashboard](bin/default_dashboard) - Show a bunch of useful information for the current directory, especially if it's a git project. Also can be called by calling 'dashboard' if you don't implement your own ./PWD_BIN/dashboard 
- [grim](bin/grim) - GRep for string and open in vIM.
- [pretty_sleep](bin/pretty_sleep) - like 'sleep' but with a visual countdown.
- [vimwhich](bin/vimwhich) - quickly edit files that are in your path (and new files)
- [todo](bin/todo) - Show TODO's, sorted by number of votes <!-- (IGNORE_TODO) -->
- [review](bin/review) - A program that displays output of other programs and refreshes on a delay with a backoff.
- [dashboard](PWD_BIN/dashboard) A overrideable program that summarizes the overall status for one directory location.
- [chbs](bin/chbs) A password generator based on xkcd's memorable "correct horse battery staple" cartoon for the few
  passwords that can't only be in your password manager and must be remembered.
- gol - Short for "Git Off my Lawn", this would be an opinionated command line tool for efficiently dealing with everyday git operations. Not written yet (TODO)

TODO's:: (run 'todo' or 'dashboard' for the full sorted list) <!-- (IGNORE_TODO) -->
===============================================================

NOTE: look in [todo_report/README.txt](todo_report/README.txt) for the 5 most important todo items, or see the whole list
sorted ascending by votes by running 'todo' at the command line. Most of the todo list is distributed around the
codebase, but there are a few miscellaneous ones collected here:

- TODO^15 with Kevin: do rust koans ( https://github.com/crazymykl/rust-koans ) so we can prepare to...
  - TODO^11 with Kevin: ...rewrite todo in rust with parallelization
- TODO^5: some tools for setting up information radiators
  - TODO^2: inforad (chrome extension?) information radiator
  - TODO: "playbot", a program that tunes in youtube livestreams, video meetings, watch later, podcasts and your personal dashboards, automatically. Great as an information radiator.
- TODO^4: output license summary in interactive programs (like you're supposed to)??
- TODO^4: commit initial skigg-utils, to get to parity with what I already like to use
- TODO^3: write a program to abbreviate output for use in the dashboard. You should be able to specify a maximum number of lines and pipe output through it, and it will do something like "head" or "tail" if necessary, but also display information about how many lines were removed/kept/found-in-total
  - TODO^2: once we can abbreviate, maybe choose the linecounts for different things dynamically depending on the terminal size
- TODO^4: consider supporting zsh
- TODO: consider trying/supporting fish
- TODO^3: try some editable vim macros
- TODO^3: set up a git hook system so you can add multiple scripts. For example, I'd like to block commits that include "XXX", irrespective of any other commit hooks. That hook might be shared by a team or individual to me, and I'd like to be able to support both kinds without conflicts.
- TODO^2: automatically graph gmail progress outstanding messages, by writing a program that takes a url or gmail search string and monitors it. You can check in on the graph periodically to make sure you're on track.
  - TODO: find a tool that can show graphs of provided data on the command line
- TODO^2: music rotator thingy
- TODO^2: collect data on email inbox, etc. and auto-generate graphs for the dashboard
  - TODO: set up router
    - TODO^2: help set up local dns
  - TODO^2: set up NAS
- TODO^2: have a way to open the github webpage from inside a git repo from the command line. You can use "open <URL>" on a mac, for example, and scripts like what you use for automatic git pushing can use it to help you get PR's going fast.
- TODO: systematized config (automate the configuration I always want anyway)
    - TODO^2: hook up to google drive
- TODO: mini-project: raspberry pi backup machine, and the software to run it.
- TODO: document usage of commands
- TODO: help set up home data center?
- TODO: put a directory in skigg-utils that contains reference/demo code that shows you how to do certain things
- TODO: implement ratcheting that can be used for code coverage, number of intstances of a string, number of lint failures, etc. It should be usable as part of a pre-merge hook for git and/or blocking a github pull request
- TODO: is there a way to commit TODO's somewhere other than local, but not show them publicly on github (I have gitignore files available, but a branching convention might be ghood for keeping them in code)?
- TODO: An [opinionated] tool for automatically seeding/templating new projects
- TODO: utility for timestamping [log] output like this: https://serverfault.com/questions/310098/how-to-add-a-timestamp-to-bash-script-log
