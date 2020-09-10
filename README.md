# skiggety-utils

My collection of convenience scripts and configuration

This is top-down programming from the very top. The first thing I do on a new computer should be to check this out and run it. It should be flexible enough that other people with different preferences can use it too, but the core mission is for myself. Once run, I should have my programs and utilities set up.

How to get started:
===================

- Open a terminal
- cd to this directory (where you checked out or downloaded this project)
- run "./start"

Core Design Decisions and Questions:
======================

  - This project uses, and helps the user use, several programming languages, since this project is a spawning ground for other projects.
  - There will be a bias towards certain tools that I prefer to use, but I'll try to make it as unobtrusive as possible. If you use bash and vim you will find extra goodies to make your life easier here, but if not there's still plenty here for you. I'm currently developing on a mac and doing some testing on a linux box, so there is bias from that, too.
  - "./PWD_BIN" should be in the user's in the PATH, which allows you to cd into a directory and run commands with simple technology-agnostic names, like "dashboard", "build", "precommit", "unit-test", "run", etc. Of course, this is scary because the meaning of these commands is changind depending on what local directory you're in, and you could run something you don't expect. To mitigate this concern, this will be configured with confirmation from the user, and PWD_BIN is a name chosen to conspicuously convey it's purpose.
    - (?) How can I make this safer? Put ./users_safeword/../PWD_BIN" in the path instead? make everything in PWD a subcommand of some other command? Come up with some handy way to add/remove it from the path quickly (or add it temporarily)? I put skiggety_utils/PWD_BIN_FIREWALL in your path before ./PWD_BIN if I wanted to block certain things
  - This project uses and enables TODO's in code, ranked so that "TODO TODO" is equal to "TODO^2" and outranks "TODO". This way you can easily add a vote when something becomes and impediment or whatever, and the cream will rise to the top. The "todo" program is a key part of this and is shown in the "default_dashboard". You can also put "IGNORE_TODO" on the same line as "TODO" if you want to mention "TODO" without it being on the list (like this).
    - TODO: 	alternate syntax idea: start all todo's as to-not-do's, add exclamation points to vote, add dollar signs to vote that they could make you money, automate a background process to clean it up into a vote tally format, ( e.g. TODO!!! becomes TODO^3, TODO^3! becomes TODO^4, maybe have a vim macro to quickly upvote things, then the todo program [hashtag #TODO_PROGRAM to discuss the program itself] should sort stuff based on that (but maybe also be aware of indentation

Cool Programs you'll find in here:
==================================

- [duh](bin/duh) - Show Directory, Username, and Hostname (in scp format). Useful in prompts.
- [grim](bin/grim) - GRep for string and open in vIM.
- [vimwhich](bin/vimwhich) - quickly edit files that are in your path (and new files)
- [todo](bin/todo) - ( TODO ... )
- [review](bin/review) - A program that displays output of other programs and refreshes.
- [dashboard](PWD_BIN/dashboard) A overrideable program that summarizes the overall status for one directory location.
- gol

misc TODO's:: (run 'todo' or 'dashboard' for the full sorted list) <!-- (IGNORE_TODO) -->
===============================================================

- TODO TODO: output license summary in interactive programs??
- TODO TODO: commit initial skigg-utils, to get to parity with what I already like to use
- TODO TODO: write a program to abbreviate output for use in the dashboard. You should be able to specify a maximum number of lines and pipe output through it, and it will do something like "head" or "tail" if necessary, but also display information about how many lines were removed/kept/found-in-total
- TODO TODO: music rotator thingy
- TODO: mini-project: raspberry pi backup machine, and the software to run it.
- TODO: "playbot", a program that tunes in youtube livestreams, video meetings, watch later, podcasts and your personal dashboards, automatically. Great as an information radiator.
- TODO: inforad (chrome extension?) information radiator
- TODO TODO: collect data on email inbox, etc. and auto-generate graphs for the dashboard
- TODO: systematized config (automate the configuration I always want anyway)
    - TODO TODO: hook up to google drive
- TODO: help set up home data center?
  - TODO: set up router
    - TODO: help set up local dns
  - TODO: set up NAS
- TODO TODO TODO: try some editable vim macros
- TODO: automatically graph gmail progress outstanding messages, by writing a program that takes a url or gmail search string and monitors it. You can check in on the graph periodically to make sure you're on track.
- TODO: put a directory in skigg-utils that contains reference/demo code that shows you how to do certain things
- TODO: implement ratcheting that can be used for code coverage, number of intstances of a string, number of lint failures, etc. It should be usable as part of a pre-merge hook for git and/or blocking a github pull request
- TODO: have a way to open the github webpage from inside a git repo from the command line. You can use "open <URL>" on a mac, for example, and scripts like what you use for automatic git pushing can use it to help you get PR's going fast.
- TODO: is there a way to commit TODO's somewhere other than local, but not show them publicly on github?
- TODO: An [opinionated] tool for automatically seeding/templating new projects
- TODO: utility for this: https://serverfault.com/questions/310098/how-to-add-a-timestamp-to-bash-script-log
