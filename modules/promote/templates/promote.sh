BRANCH=$1
git branch -m master master-$BRANCH
git branch -m $BRANCH master
git checkout master