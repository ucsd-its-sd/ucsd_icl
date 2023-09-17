echo "Term: $1";
ICLTERM=$1

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR/data &&
export ICLTERM=$ICLTERM &&
deno task classrooms:scrape-to-file &&
INPATH=$SCRIPT_DIR/data/classrooms/data/classrooms-$ICLTERM-full.txt &&
OUTPATH=$SCRIPT_DIR/web/source/classrooms-$ICLTERM-full.txt &&
cp $INPATH $OUTPATH &&
HTMLPATH=$SCRIPT_DIR/web/index.html &&
TXTHTMLPATH=./source/classrooms-$ICLTERM-full.txt &&
node $SCRIPT_DIR/replacePath.js $HTMLPATH $OUTPATH $TXTHTMLPATH $ICLTERM &&
cd $SCRIPT_DIR/web &&
BRANCH=`git branch --show-current` &&
git checkout main &&
git add . &&
git commit &&
git push origin main &&
git checkout $BRANCH
