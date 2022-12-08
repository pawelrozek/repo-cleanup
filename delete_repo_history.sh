#!/bin/bash

#Prompt user to insert inputs (one at a time)
read -p 'Enter path to your git repo ' DIR_PATH

#check for empty user input...
if [ -z "$DIR_PATH"] ; then
  echo "No input provided, exiting...."
  exit 1
fi

cd "$DIR_PATH"

#Checkout
git checkout --orphan latest_branch

#Add all the files

git add -A

#Commit the changes

git commit -am "commit message"

#Delete the branch

git branch -D main

#Rename the current branch to main

git branch -m main

# Ask user if they're sure they want to continue
read -p 'Are you sure you want to commit the changes to your github respository? y/n' ANSWER

# Confirm user's input
if [ -z "$ANSWER"] ; then
  echo "No input provided, so assuming \"n\". Exiting without committing changes...."
  echo "If you want to commit the changes please run the following command:"
  echo "          git push -f origin main"
  exit 1
fi
# user answered No or Yes
if [ "$ANSWER" == "n" ] || [ "$ANSWER" == "N" ] ; then
  echo "You've answered \"n\". Exiting without committing changes...."
  echo "If you want to commit the changes please run the following command:"
  echo "          git push -f origin main"
  exit 0
else
  echo "Proceeding to commit changes to github respository..."
  #Finally, force update your repository
  git push -f origin main
  echo "Completed..."
  exit 0
fi
