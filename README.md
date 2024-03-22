# skiggety-utils

My collection of convenience scripts and configuration. Basically I checkout this git repo on a new computer and run
'./start' to get everything the way I like it, including 3rd-party programs and my own stuff. I expect to use this as a
spawning ground for other projects that will move on to their own repos.

## Requirements
* bash

## How to get started:

There are two options, a docker demo to try it safely, or a normal mode to install skiggety-utils and other preferrred
software on your machine.

For the safe docker demo:

- git clone this project
- Open a terminal and cd to this directory
- run "./demo_in_docker"
- Follow the prompts, instructions, and read the output. By the end, you should know what's going on.

...or for the full experience:

- git clone this project
- Open a terminal and cd to this directory
- run "./start"
- Follow the prompts, instructions, and read the output. By the end, you should know what's going on.

### Prerequisites:
- bash

## Design

  This is a sandbox and a miscellaneous bin among other things, so there is no one design per se, but there are some
  core ideas:

  - This project uses, and helps the user use, several programming languages, since this project is a spawning ground for other projects.
  - These tools are opinionated, in general. This is a personal sandbox after all
    - vim is good, especially when appropriately accessorized.
    - Terminals are nice, in all shapes and sizes. The order of what's displayed in
      [PWD_BIN/dashboard](PWD_BIN/dashboard) and [PWD_BIN/dev](PWD_BIN/dev) reflects this, in that you always see the
      most important stuff that your terminal has room for. [todo](bin/todo) is so terminal-friendly that it sorts
      results in reverse, so that the most important information hasn't scrolled off the screen ('top' doesn't even mean
      'most important' anymore, how strange)
    - the default git ui requires typing too many commands
    are pretty clear.
  - reducing the number of steps for developer tasks is common theme. Most of the git subcommands are about that. 'review' manages one
    terminal for you so you don't have to keep switching back to it.
  - "./PWD_BIN" should be in the user's in the PATH, which allows you to cd into a directory and run commands with simple technology-agnostic names, like "dev" "dashboard", "build", "precommit", "unit-test", "run", etc. This is all about what I think of as developer ergonomics, because it helps fit the project to the developer. For example, I tend to put whatever my current development cycle is into one place and call it ./PWD_BIN/dev (under whatever project), which means I can come back to that project with faded memories and quickly get going again my (maybe reading first) and running 'dev'. Of course, this is scary because the meaning of these commands is changind depending on what local directory you're in, and you could run something you don't expect. To mitigate this concern, this will be configured with confirmation from the user, and PWD_BIN is a name chosen to conspicuously convey it's purpose.
    - TODO^7: by the way, figure out how to tack one git repo on to another so you don't have ./PWD_BIN always showing up in the
    - TODO^3: fix the BUG where you run todo (PWD_BIN/todo) and then cd to test/ and run todo and it complains
      about ./PWD_BIN/todo instead of finding $SKIGGETY_UTILS_DIR/bin/todo. 'exec bash' is the workaround.
      uncommitted files in other git repos. This is also important so git-vimchanged can work properly when you add
      your own PWD_BIN with convenience scripts to another repo
    - (?) How can I make this safer? (TODO^4: consider direnv: "https://direnv.net/docs/hook.html") and dotenv. Put ./users_safeword/../PWD_BIN" in the path instead? make everything in PWD a subcommand of some other command? Come up with some handy way to add/remove it from the path quickly (or add it temporarily)? I put skiggety-utils/PWD_BIN_FIREWALL in your path before ./PWD_BIN if I wanted to block certain things

  - This project uses and enables TODO's in code, ranked so that "TODO TODO" is equal to "TODO^2" and outranks "TODO". This way you can easily add a vote when something becomes and impediment or whatever, and the cream will rise to the top. The "todo" program is a key part of this and is shown in the "default_dashboard". You can also put "IGNORE_TODO" on the same line as "TODO" if you want to mention "TODO" without it being on the list (like this).

## Thing you can run, a.k.a: Programs, scripts, and shortcuts you'll find in here:

- [chbs](bin/chbs) A password generator based on xkcd's memorable "correct horse battery staple" cartoon for the few
  passwords that must be remembered so they can get you into your computer or password manager.
- [demo_in_docker](./demo_in_docker) - try skiggety-utils in a safe sandbox!
- [PWD_BIN/dev](PWD_BIN/dev) - The basic dev cycle I use to develop this suite most of the time. if tests work, it moves
  on to linting, then dashboard, etc. Good when combined with review as in 'review dev'. Prone to lots of change but I
  try to keep it fast, deterministic, and concise.
- [duh](bin/duh) - Show Directory, Username, and Hostname (in scp format). Useful in prompts.
- [abbreviate](bin/abbreviate) - A verbose alternative to tail, that displays a helpful method when output gets cut off
- [dashboard](PWD_BIN/dashboard) A overrideable program that summarizes the overall status for one directory location.
- [default_dashboard](bin/default_dashboard) - Show a bunch of useful information for the current directory, especially if it's a git project. Also can be called by calling 'dashboard' if you don't implement your own ./PWD_BIN/dashboard 
- [devkit installer](installers/devkit) - Install just what's needed to work on these programs
- various *git* subcommands:
  - [git-attempt-checkout](bin/git-attempt-checkout) - finds a branch by substring and checks it out quickly
  - [git-pretty-pull](bin/git-pretty-pull) - git pull with a little bit of extra information.
  - [git-push-new-branch](bin/git-push-new-branch) - basically just 'git checkout -b' and 'git push -u' put together, a
    way to create matching branches locally and upstream as one step once you decide th name
  - [git-put](bin/git-put) - git commiT and PUsh in one step
  - [git-ready](bin/git-ready) - check over your changes and then commit and push them. One script to run to get my
    changes putshed up when they are working on disk, even if I'm not going to commit every last line.
  - [git-subtract](bin/git-subtract) - just the opposite of 'git add', lol
  - [git-vimchanged](bin/git-vimchanged) - quickly open up all the files that have local changes in my favorite editor
  - [git-vimdiff](bin/git-vimdiff) - my usual diff util as it's own explicit subcommand in case you want to have a more
    read-only diff tool as your other difftool
- [grim](bin/grim) - GRep for string and open in vIM. This is what you use when you can remember a unique key word or
  phrase in the text location where you want to edit quicker than you can remember the file name. Also good for shotgun
  surgery since you can find all occurrences quickly.
- [newbin](bin/newbin) - The quickest way to start editing a new script in your path. Try "newbin myscript env ruby" or
  "newbin myscript".
- [review](bin/review) - A program that displays output of other programs and refreshes on a delay with a backoff.
- [shebang](bin/shebang) - quickly produces a shebang line for the top of your script. Try
'shebang env bash > my_new_script' to get the idea
- [shellask](bin/shellask) - ask/assign the user a question/task and give them a shell to answer/accomplish it. Works
  for stubbing out functionality, as a shell breakpoint, or for setting yourself reminders that can nest.
- [todo](bin/todo) - Show and lint TODO's, sorted by number of votes. <!-- (IGNORE_TODO) --> This has evolved to suit my
  own usage. Basically I vote when something bugs me and this program shows me what I have wanted the most over time so
  I can work on that.
- [sleep-verbose](bin/sleep-verbose) - like 'sleep' but with a visual countdown, because I want details if I have to
  wait.
- [vimfirst](bin/vimfirst) - it's just vimwhich and run. with my alias to shorten it, commands like 'vf todo -w' are
  useful to quickly edit an run an override script or program
- [vimwhich](bin/vimwhich) - quickly edit files that are in your path (and new files). Also "vw" is an alias.

## TODO list <!-- IGNORE_TODO -->

The todo list is denoted with the 'TODO' <!--IGNORE_TODO--> keyword all over code and managed by the 'todo' program.

### The most important tasks 'to do' next...
...are in [todo_report/README.txt](todo_report/README.txt), and they are sorted in *ascending* order. Note the filename
and line number pointing to the origin of each item.

### The full list ..
...can be seen by running 'todo' at the command line from within this directory.

And by the way, a todo with a vote or 2 is really a "to-not-do", or a
"to-do-if-you-are-in-the-neighborhood-and-it-would-be-wicked-easy". That's the key to the whole thing. Not doing
everything you can, doing the things that come up often enough earn some votes. In some cases, you might want to make
that more explicit, and it turns out writing "TODO^0" <!-- IGNORE_TODO --> works just fine for those cases when you
really want to make sure you remember not do it.

So anyway, you don't really need to look at the full list, just a screen-full or so.

### Miscellaneous

These ideas don't have a code location, so they go here:

  - TODO^56: firstlife
    - TODO^111: move firstlife to 'zerothlife' repo
      - TODO^114: (IN_PROGRESS, NOW) at least check out the repo, maybe with a skiggety-utils installer
      - TODO^109: see what else in ./bin/silliness might belong in zerothlife repo
  - TODO^116: move 'vital' data (to do list) to private repo (skiggety utils should help set up)
  - TODO^48: spin off kid-utils
  - TODO^21: ...rewrite todo in rust with parallelization (maybe with Kevin), but after [rust koans](https://github.com/crazymykl/rust-koans)
- TODO^6: some tools for setting up information radiators
- TODO^3: toy rails site, need a good idea, maybe it can help with information radiating?
  - TODO^2: inforad (chrome extension?) information radiator
  - TODO: "playbot", a program that tunes in youtube livestreams, video meetings, watch later, podcasts and your personal dashboards, automatically. Great as an information radiator.
  - TODO: something to keep randomized youtube playlists playing without interruption for music and such
  - TODO: 'rod' would be a good name for a transparent screen locker. It would stand for "Read-Only Display"
- TODO^4: output license summary in interactive programs (like you're supposed to)??
- TODO^4: commit initial skigg-utils, to get to parity with what I already like to use
- TODO^9: consider supporting other shells:
  - TODO^6: consider trying/supporting fish
  - TODO^4: consider supporting zsh
- TODO^5: use bash linter of some sort
- TODO^4: set up a git hook system so you can add multiple scripts. For example, I'd like to block commits that include
- TODO^3: try some editable vim macros
  "X X X" (without the spaces), irrespective of any other commit hooks. That hook might be shared by a team or
  individual to me, and I'd like to be able to support both kinds without conflicts. Look at
  https://github.com/pre-commit/pre-commit
- TODO^4: music rotator thingy (Neighbor Shawn might beta test)
- TODO^3: maybe skiggety-utils should help set up /Users/skiggety/PWD_BIN/dashboard from a template
- TODO^2: automatically graph gmail progress outstanding messages, by writing a program that takes a url or gmail search string and monitors it. You can check in on the graph periodically to make sure you're on track.
  - TODO: find a tool that can show graphs of provided data on the command line
- TODO^2: collect data on email inbox, etc. and auto-generate graphs for the dashboard
  - TODO: set up router
    - TODO^2: help set up local dns
  - TODO^2: set up NAS
- TODO^2: have a way to open the github webpage from inside a git repo from the command line. You can use "open <URL>" on a mac, for example, and scripts like what you use for automatic git pushing can use it to help you get PR's going fast.
- TODO^2: mini-project: raspberry pi backup machine, and the software to run it.
- TODO: systematized config (automate the configuration I always want anyway)
    - TODO^2: hook up to google drive
# TODO^7: set up bash tab completion ( see: https://apple.stackexchange.com/questions/55875/git-auto-complete-for-branches-at-the-command-line )
- TODO: document usage of commands
- TODO: help set up home data center?
- TODO: put a directory in skigg-utils that contains reference/demo code that shows you how to do certain things
- TODO: implement ratcheting that can be used for code coverage, number of intstances of a string, number of lint failures, etc. It should be usable as part of a pre-merge hook for git and/or blocking a github pull request
- TODO: is there a way to commit TODO's somewhere other than local, but not show them publicly on github (I have gitignore files available, but a branching convention might be ghood for keeping them in code)?
- TODO: An [opinionated] tool for automatically seeding/templating new projects
- TODO: utility for timestamping [log] output like this: https://serverfault.com/questions/310098/how-to-add-a-timestamp-to-bash-script-log
- TODO?: gol - Short for "Git Off my Lawn", this would be an opinionated command-line front end for git.
