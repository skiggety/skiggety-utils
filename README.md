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
  - This project uses and enables TODO's in code, ranked so that "TODO TODO" is equal to "TODO^2" and outranks "TODO". This way you can easily add a vote when something becomes and impediment or whatever, and the cream will rise to the top. The "todo" program is a key part of this and is shown in the "default_dashboard". You can also put "IGNORE_TODO" on the same line as "TODO" if you want to mention "TODO" without it being on the list (like this).
    - TODO: 	alternate syntax idea: start all todo's as to-not-do's, add exclamation points to vote, add dollar signs to vote that they could make you money, automate a background process to clean it up into a vote tally format, ( e.g. TODO!!! becomes TODO^3, TODO^3! becomes TODO^4, maybe have a vim macro to quickly upvote things, then the todo program [hashtag #TODO_PROGRAM to discuss the program itself] should sort stuff based on that (but maybe also be aware of indentation
  - "./PWD_BIN" should be in the user's in the PATH, which allows you to cd into a directory and run commands with simple technology-agnostic names, like "dashboard", "build", "precommit", "unit-test", "run", etc. Of course, this is scary because the meaning of these commands is changind depending on what local directory you're in, and you could run something you don't expect. To mitigate this concern, this will be configured with confirmation from the user, and PWD_BIN is a name chosen to conspicuously convey it's purpose.
    - (?) How can I make this safer? Put ./users_safeword/../PWD_BIN" in the path instead? make everything in PWD a subcommand of some other command? Come up with some handy way to add/remove it from the path quickly (or add it temporarily)?

Cool Programs you'll find in here:
==================================

- duh
- [grim](bin/grim)
- gol
- review
- [todo](bin/todo)
- vimwhich

misc TODO's:: (run  todo or dashboard for the full sorted list) (IGNORE_TODO)
===============================================================

- TODO TODO: commit initial skigg-utils, to get to parity with what I already like to use
- TODO: install other stuff (start automating installer in skigg-utils)
    - TODO TODO: setup backups
- TODO: mini-project: raspberry pi backup machine, and the software to run it.
- TODO: systematized config (automate the configuration I always want anyway)
    - TODO: terminal profiles
        - TODO TODO: commit/sync/install mac terminal profiles?
        - TODO: ... and linux ones too

