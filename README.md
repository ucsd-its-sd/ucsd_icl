# ITS Classroom Lookup

## What is this?

It's like the [Sheeptester tool](https://sheeptester.github.io/uxdy/classrooms/) but specifically for use by ITS Classroom Support for quickly looking up who the professor is in a given room at a given time.

## Why is it split into 3 repositories?

- [`ucsd-its-sd/icl_web`](https://github.com/ucsd-its-sd/icl_web): Specifically the web component, built automatically by this portion and hosted on Github Pages at [icl.ucsd.it](https://icl.ucsd.it)
- [`ucsd-its-sd/icl_data`](https://github.com/ucsd-its-sd/icl_data): A fork of `sheeptester/uxdy` to fetch classroom information
- `ucsd-its-sd/ucsd_icl`: The build scripts and actions that tie the other two repositories together.

## How do I use this?

Required to build this:
- [node](https://nodejs.org/en)
- [deno](https://deno.com/)

Usage:
`sh ./build.sh [ICLTERM] [SCRIPT_DIR]`

- `ICLTERM`: eg. SP24 or WI95
- `SCRIPT_DIR`: This will usually be `.` or `` `pwd` ``

Flags and environment variables:
- `$ICLTERM`: The same as above
- `$SCRIPT_DIR`: The same as above
- `$GIT_PATH`, `$DENO_PATH`, `$NODE_PATH`: The executables for the respective projects.
- `$WEB_BRANCH`, `$ICL_BRANCH`, `$WEB_REMOTE`, `$ICL_REMOTE`: Settings for pushing to the git repos.
- `$NOPUSH`: Don't push built website to the remote.
- `$NOBUILD`: Don't scrape and build classroom data.

<!-- Update the link below when we contribute back to the main repository -->
A good example of how to use these flags and parameters is the use in the [workflow](https://github.com/stassinopoulosari/ucsd_icl_actions_test/blob/main/.github/workflows/run-scrape.yml)

## Questions?

Please reach out! hello@ari-s.com
