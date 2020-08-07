# skiggety-utils

My collection of convenience scripts and configuration

This is top-down programming from the very top. The first thing I do on a new computer should be to check this out and run it. It should be flexible enough that other people with different preferences can use it too, but the core mission is for myself. Once run, I should have my programs and utilities set up.

How to get started:
===================

- Open a terminal
- cd to this directory
- run "./start"

Core Design Decisions and Questions:
======================

  - "./PWD_BIN" should be in the user's in the PATH, which allows you to cd into a directory and run commands with simple technology-agnostic names, like "dashboard", "build", "precommit", "unit-test", "run", etc. Of course, this is scary because the meaning of these commands is changind depending on what local directory you're in, and you could run something you don't expect. To mitigate this concern, this will be configured with confirmation from the user, and PWD_BIN is a name chosen to conspicuously convey it's purpose.
    - (?) How can I make this safer? Put ./users_safeword/../PWD_BIN" in the path instead? make everything in PWD a subcommand of some other command? Come up with some handy way to add/remove it from the path quickly (or add it temporarily)?

