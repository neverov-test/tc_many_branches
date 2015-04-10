#!/usr/bin/env bash

set -e
#set -x

# You can override the branch prefix with the first positional argument.
BRANCH_PREFIX=${1:-"tc-testing"}

# You can override the number of branches created with the second positional argument.
NUM_BRANCHES=${2:-"10"}

for i in `seq 1 $NUM_BRANCHES`;
do
  BRANCH="$BRANCH_PREFIX-$i"
  if git show-ref --verify --quiet refs/heads/$BRANCH; then
    echo "branch $BRANCH" already exists!
# Uncomment below to delete branches.
    echo "branch $BRANCH" already exists, deleting!
    git branch -D --quiet $BRANCH
  else
    echo "branch $BRANCH" does not exist, creating!
    git checkout --quiet -b $BRANCH
    touch $BRANCH
    git add $BRANCH
    git commit --quiet -m "Creating Branch $BRANCH"
    git checkout --quiet master
  fi
done
