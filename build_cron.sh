#!/bin/sh
# Script to automatically build classrooms, safe(-ish?) to use with cron.

alias git=${GIT_PATH:-'/usr/bin/git'}
alias node=${NODE_PATH:-'/usr/local/bin/node'}
alias deno=${DENO_PATH:-'~/.deno/bin/deno'}
WEB_BRANCH=${WEB_BRANCH:-'main'}
ICL_BRANCH=${ICL_BRANCH:-'main'}
WEB_REMOTE=${WEB_REMOTE:-'origin'}
ICL_REMOTE=${ICL_REMOTE:-'origin'}
NOPUSH=${NOPUSH-'0'}
NOBUILD=${NOBUILD-'0'}
ICLTERM=${ICLTERM:-$1}
SCRIPT_DIR=$ICL_PATH

if [ -z "$ICLTERM" ]
then
    echo "usage: sh build.sh [TERM]"
    exit 0
else
    echo "Term: $ICLTERM"
fi

if [ -z "$SCRIPT_DIR" ]
then
    echo "please make sure \$SCRIPT_DIR is set."
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
cd $SCRIPT_DIR/data
if [ "$NOBUILD" = "0" ]; then
    ICLTERM="$ICLTERM" deno task classrooms:scrape-to-file
fi
DATETIME=`date -Iseconds`
INPATH="$SCRIPT_DIR/data/classrooms/data/classrooms-$ICLTERM-full.txt"
OUTPATH="$SCRIPT_DIR/web/source/classrooms-$ICLTERM-full.txt"
cp $INPATH $OUTPATH
echo "$SCRIPT_DIR/web/index.html"
HTMLPATH="$SCRIPT_DIR/web/index.html"
TXTHTMLPATH="./source/classrooms-$ICLTERM-full.txt"
node $SCRIPT_DIR/replacePath.js $HTMLPATH $OUTPATH $TXTHTMLPATH $ICLTERM
cd $SCRIPT_DIR/web
BRANCH=`git branch --show-current`
if [ "$BRANCH" != "$WEB_BRANCH" ]; then
        git checkout $WEB_BRANCH
fi
git add $HTMLPATH
git add $OUTPATH
git commit -m "Build for $ICLTERM at $DATETIME"
if [ "$NOPUSH" = "0" ]; then
    git push $WEB_REMOTE $WEB_BRANCH
fi
if [ "$BRANCH" != "$WEB_BRANCH" ]; then
        git checkout $BRANCH
fi
cd $SCRIPT_DIR
BRANCH=`git branch --show-current`
if [ "$BRANCH" != "$ICL_BRANCH" ]; then
	git checkout $ICL_BRANCH
fi
git add web
git commit -m "Update commit for web at $DATETIME"
if [ "$NOPUSH" = "0" ]; then
    git push $ICL_REMOTE $ICL_BRANCH
fi
if [ "$BRANCH" != "$ICL_BRANCH" ]; then
	git checkout $BRANCH
fi
