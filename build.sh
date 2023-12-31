ICLTERM=$1

if [ -z "$ICLTERM" ]
then
    echo "usage: sh build.sh [TERM]"
    exit 0
else
    echo "Term: $1"
fi

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR/data &&
export ICLTERM=$ICLTERM &&
deno task classrooms:scrape-to-file &&
DATETIME=`date -Iseconds` &&
INPATH=$SCRIPT_DIR/data/classrooms/data/classrooms-$ICLTERM-full.txt &&
OUTPATH=$SCRIPT_DIR/web/source/classrooms-$ICLTERM-full.txt &&
cp $INPATH $OUTPATH &&
HTMLPATH=$SCRIPT_DIR/web/index.html &&
TXTHTMLPATH=./source/classrooms-$ICLTERM-full.txt &&
node $SCRIPT_DIR/replacePath.js $HTMLPATH $OUTPATH $TXTHTMLPATH $ICLTERM &&
cd $SCRIPT_DIR/web &&
BRANCH=`git branch --show-current` &&
git checkout main &&
git add $HTML_PATH $OUTPATH &&
git commit -m "Build for $ICLTERM at $DATETIME" &&
git push origin main &&
git checkout $BRANCH &&
cd $SCRIPT_DIR &&
BRANCH=`git branch --show-current` &&
git checkout main &&
git add web &&
git commit -m "Update commit for web at $DATETIME" &&
git push origin main &&
git checkout $BRANCH
