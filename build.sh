#!/bin/bash
# Script to automatically build classrooms, safe(-ish?) to use with cron.
source ./config.sh

# Some of these files aren't included in the path for cron.
GITPATH=`command -v git`
NODEPATH=`command -v node`
DENOPATH=`command -v deno`
alias git=${GITPATH:-${GIT_PATH:-'/usr/bin/git'}}
alias node=${NODEPATH:-${NODE_PATH:-'/usr/local/bin/node'}}
alias deno=${DENOPATH:-${DENO_PATH:-'~/.deno/bin/deno'}}

# In case you want to use gh-pages or something, idk
WEB_BRANCH=${WEB_BRANCH:-'main'}
ICL_BRANCH=${ICL_BRANCH:-'main'}
WEB_REMOTE=${WEB_REMOTE:-'origin'}
ICL_REMOTE=${ICL_REMOTE:-'origin'}
# Some flags for testing (NOPUSH or NOBUILD can be equal to 1 to skip pushing or building
NOPUSH=${NOPUSH-'0'}
NOBUILD=${NOBUILD-'0'}
# We need the term for classes as well as a good directory for this file
ICLTERM=${ICLTERM:-$1}
ICLFINALS=${ICLFINALS:-'0'}
SCRIPT_DIR=`temp=$( realpath "$0"  ) && dirname "$temp"`
# Get the build date/time
# Get the datetime before build for the commit name
DATETIME=`date -Iseconds`

echo "CONFIG: FINALS -> $ICLFINALS, TERM -> $ICLTERM"

if [ -z "$ICLTERM" ]
then
    echo "usage: sh build.sh [TERM] [SCRIPT_DIRECTORY]"
    exit 0
else
    echo "Term: $ICLTERM"
fi

if [ -z "$SCRIPT_DIR" ]
then
    echo "usage: sh build.sh [TERM] [SCRIPT_DIRECTORY]"
    exit 0
else
    echo "Script Directory: $SCRIPT_DIR"
fi

if [ "$NOPUSH" != "0" ]
then
    echo "\$NOPUSH flag is set. will skip pushing."
fi

if [ "$NOBUILD" != "0" ]
then
    echo "\$NOBUILD flag is set. will skip building."
fi
# Move into `data` directory (cloned from the original uxdy package)
cd $SCRIPT_DIR/data
if [ "$NOBUILD" = "0" ]; then
    # Build the actual classroom file
    ICLTERM="$ICLTERM" deno task classrooms:scrape-to-file
fi
# Pull the latest version of the web before copying the output file.
cd $SCRIPT_DIR/web
# Change the branch if it's not already on the correct one
BRANCH=`git branch --show-current`
if [ "$BRANCH" != "$WEB_BRANCH" ]; then
        git checkout $WEB_BRANCH
fi
git pull $WEB_REMOTE $WEB_BRANCH
# Move back to the data directory and copy the data files
cd $SCRIPT_DIR/data
# Copy the text file with the classroom data
INPATH="$SCRIPT_DIR/data/classrooms/data/classrooms-$ICLTERM-full.txt"
OUTPATH="$SCRIPT_DIR/web/source/classrooms-full.txt"
if [ "$NOBUILD" = "0" ]; then
	cp $INPATH $OUTPATH
	if [ "$ICLFINALS" = "0" ]; then
	   echo FALSE > $SCRIPT_DIR/web/source/FINALS
	else
	   echo TRUE > $SCRIPT_DIR/web/source/FINALS
	fi
fi
# Add the `info` class to the classes file
HTMLPATH="$SCRIPT_DIR/web/index.html"
node $SCRIPT_DIR/addClassInfo.js $OUTPATH $ICLTERM
# Move into the web directory
cd $SCRIPT_DIR/web
# Change the text file
git add $OUTPATH
# Make a new commit for this build
git commit -m "Build for $ICLTERM at $DATETIME"
# Push to origin if NOPUSH is not set
if [ "$NOPUSH" = "0" ]; then
    git push $WEB_REMOTE $WEB_BRANCH
fi
# Go back to the original branch
if [ "$BRANCH" != "$WEB_BRANCH" ]; then
        git checkout $BRANCH
fi
# Move back into the main directory (because we have `web` and `data` as submodules, we need to keep the original up to date
cd $SCRIPT_DIR

BRANCH=`git branch --show-current`
# Change the branch if it's not already on the correct one
if [ "$BRANCH" != "$ICL_BRANCH" ]; then
	git checkout $ICL_BRANCH
fi
git add web
# Make a new commit for this build
git commit -m "Update commit for web at $DATETIME"
# Push to origin if NOPUSH is not set
if [ "$NOPUSH" = "0" ]; then
    git push $ICL_REMOTE $ICL_BRANCH
fi

# Go back to the original branch
if [ "$BRANCH" != "$ICL_BRANCH" ]; then
	git checkout $BRANCH
fi
